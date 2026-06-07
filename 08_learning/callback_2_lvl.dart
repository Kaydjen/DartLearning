class MyButton {
/*   void main() {
    // Создаем кнопку "Сохранить" и даем ей логику
    var saveButton = MyButton(
      label: "Save",
      onPressed: () {
        print("Файл успешно сохранен в базу данных!");
      },
    );

    // Создаем кнопку "Отмена", но НЕ даем ей логику (null по умолчанию)
    var cancelButton = MyButton(label: "Cancel");

    // Проверяем работу
    saveButton.click(); // Выполнит логику
    cancelButton.click(); // Просто напишет, что действия нет
  } */
  MyButton(this.label, {this.onPressed});
  String label;
  ButtonCallback? onPressed;
  void onClick() {
    print("Нажата кнопка: [$label]");
    if (onPressed == null) {
      print("Действие не назначено");
    } else {
      onPressed?.call();
    }
  }
}

typedef ButtonCallback = void Function();
