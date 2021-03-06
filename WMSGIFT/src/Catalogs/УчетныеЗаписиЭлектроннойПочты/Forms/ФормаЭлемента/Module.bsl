
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Объект.ИмяПредопределенныхДанных=Справочники.УчетныеЗаписиЭлектроннойПочты.СистемнаяУчетнаяЗапись Тогда 
		Если не РольДоступна("ПолныеПрава") Тогда 
			ЭтаФорма.ТолькоПросмотр=Истина;
		КонецЕсли;	
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПроверкаСвязиНаСервере()
	Профиль = Новый ИнтернетПочтовыйПрофиль;
	Профиль.АдресСервераSMTP = Объект.SMTPСервер;
	Профиль.ПользовательSMTP = Объект.ЛогинSMTP;
	Профиль.ПарольSMTP = Объект.ПарольSMTP;
	Профиль.ИспользоватьSSLSMTP = Истина;
	Профиль.ПортSMTP = Объект.ПортSMTP; 
	Профиль.АутентификацияSMTP = СпособSMTPАутентификации.Login;
	Почта = Новый ИнтернетПочта; 
	Попытка
		Почта.Подключиться(Профиль);
		Сообщить("Подключено");
	Исключение
		Сообщить("Не удалось подключиться к серверу");
		Сообщить(ОписаниеОшибки());
	КонецПопытки;
	Почта.Отключиться();
	Сообщить("Соединение завершено");
КонецПроцедуры

&НаКлиенте
Процедура ПроверкаСвязи(Команда)
	ПроверкаСвязиНаСервере();
КонецПроцедуры
