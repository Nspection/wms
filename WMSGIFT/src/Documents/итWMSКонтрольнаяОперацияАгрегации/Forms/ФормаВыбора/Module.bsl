&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("итОснование") тогда
		НовыйЭлементОбора=Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		НовыйЭлементОбора.ЛевоеЗначение= Новый ПолеКомпоновкиДанных("итОснование");
		НовыйЭлементОбора.ВидСравнения=ВидСравненияКомпоновкиДанных.Равно;
		НовыйЭлементОбора.ПравоеЗначение=Параметры.итОснование;
    КонецЕсли;
КонецПроцедуры

