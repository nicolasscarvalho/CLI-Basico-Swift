View().main()

class UserModel {
  var name: String = ""
  var notes: Array<NoteModel> = []
}

class NoteModel {
  var text: String

  init(_ text: String) {
    self.text = text
  }
}

enum Route {
  case home, options, addNote, readNote, updateNote, deleteNote
}

class View {
  var viewModel: ViewModel = .init()

  func main() {

    while true {
      switch viewModel.route {
        case .home:
          homeView()
        case .options:
          optionsView()
        case .addNote:
          addNoteView()
        case .readNote:
          readNoteView()
        case .updateNote:
          updateNoteView()
        case .deleteNote:
          deleteNoteView()
        default:
          print("Opção inválida, tente novamente.")
      }
    }

  }

  func homeView() {
    print("Olá! Qual o seu nome?")
    if !viewModel.setName() {
      print("Nome inválido, tente novamente.")
    }
  }

  func optionsView() {
    print("\n" + String(repeating: "===", count: 15))
    print("Seja bem vindo, \(viewModel.user.name)! O que você deseja realizar?")
    print("A - Adicionar nota\nB - Ler nota\nC - Editar nota\nD - Deletar nota\n")

    if !viewModel.setOption() {
      print("Opção inválida, tente novamente.")
    }
  }

  func addNoteView() {
    print("Digite a nota que você deseja adicionar:")
    if viewModel.addNote() {
      print("Nota adicionada com sucesso!")
    }

    else {
      print("Nota inválida, tente novamente.")
    }
  }

  func readNoteView() {
    if viewModel.readNote() {
      print("\nNotas exibidas com sucesso")
    }

    else {
      print("Você ainda não tem notas cadastradas.")
    }
  }

  func updateNoteView() {
    if viewModel.updateNote() {
      print("Nota atualizada com sucesso!")
    }  

    else {
      print("Índice e/ou nota inválida, tente novamente.")
    }
  }

  func deleteNoteView() {
    if viewModel.deleteNote() {
      print("Nota deletada com sucesso!")
    }

    else {
      print("Índice inválido, tente novamente.")
    }
  }
}

class ViewModel {
  var route: Route = .home
  var user: UserModel = .init()

  func setName() -> Bool {
    print("> ", terminator: "")
    let userName = readLine()

    if let userName = userName {
      user.name = userName
      route = .options
      return true
    }

    else {
      return false
    }
  }

  func setOption() -> Bool {
    print("> ", terminator: "")
    let userOption = readLine()

    if let userOption = userOption {
      switch userOption.uppercased() {
        case "A":
          route = .addNote
        case "B":
          route = .readNote
        case "C":
          route = .updateNote
        case "D":
          route = .deleteNote
        default:
          print("Opção inválida, tente novamente.")  
      }
      return true
    }
    else {
      return false
    }
  }

  func addNote() -> Bool {
    route = .options

    print("> ", terminator: "")
    let userNote = readLine()

    if let userNote = userNote {
      user.notes.append(NoteModel(userNote))
      return true
    }

    else {
      return false
    }
  }

  func readNote() -> Bool {
    route = .options

    if user.notes.count != 0 {
      for (index, note) in user.notes.enumerated() {
        print("\(index + 1) - \(note.text)")
      }
      return true
    }

    else {
      return false
    }
  }

  func updateNote() -> Bool {
    route = .options

    print("Digite o índice da nota que deseja editar:")
    print("> ", terminator: "")
    let selectedIndex = readLine()

    print("Digite agora o novo conteúdo da nota:")
    print("> ", terminator: "")
    let newNote = readLine()

    if let selectedIndex = selectedIndex, let newNote = newNote{
      if !(Int(selectedIndex)! - 1 < user.notes.count - 1 || Int(selectedIndex)! - 1 > user.notes.count - 1) {
        user.notes[Int(selectedIndex)! - 1].text = newNote
        return true
      }

      else {
        return false
      }
    }

    else {
      return false
    }
  }

  func deleteNote() -> Bool {
    route = .options

    print("Digite o índice da nota que deseja deletar:")
    print("> ", terminator: "")

    let selectedIndex = readLine()

    if let selectedIndex = selectedIndex {
      if !(Int(selectedIndex)! - 1 < user.notes.count - 1 || Int(selectedIndex)! - 1 > user.notes.count - 1) {
        user.notes.remove(at: Int(selectedIndex)! - 1)
        return true
      }

      else {
        return false
      }
    }

    else {
      return false
    }
  }

}
