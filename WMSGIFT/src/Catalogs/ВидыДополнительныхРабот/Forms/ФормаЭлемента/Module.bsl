
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Элементы.ПараметрыШаблонаТипЗначения.СписокВыбора.Добавить("Строка");
	Элементы.ПараметрыШаблонаТипЗначения.СписокВыбора.Добавить("Число");
	Элементы.ПараметрыШаблонаТипЗначения.СписокВыбора.Добавить("Булево");
	Элементы.ПараметрыШаблонаТипЗначения.СписокВыбора.Добавить("Дата");
КонецПроцедуры

&НаСервере
Процедура СтраницыПриСменеСтраницыНаСервереФормула()
	СписокПараметров.Очистить();
	Для Каждого стр из Объект.ПараметрыШаблона Цикл
		Если стр.ТипЗначения="Число" Тогда 
			СписокПараметров.Добавить(стр.ИмяПараметра);
		КонецЕсли;
	КонецЦикла;
	СписокПараметров.Добавить("*");
	СписокПараметров.Добавить("+");
	СписокПараметров.Добавить("-");
	СписокПараметров.Добавить("/");

КонецПроцедуры

&НаКлиенте
Процедура СтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	Если ТекущаяСтраница.Имя="Формула" Тогда 
	СтраницыПриСменеСтраницыНаСервереФормула();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура СписокПараметровВыборНаСервере(Значение)
	Объект.ФормулаШаблона=Объект.ФормулаШаблона+Значение;
КонецПроцедуры

&НаКлиенте
Процедура СписокПараметровВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Значение=ТекущийЭлемент.ТекущиеДанные.Значение;
	СписокПараметровВыборНаСервере(Значение);
КонецПроцедуры
