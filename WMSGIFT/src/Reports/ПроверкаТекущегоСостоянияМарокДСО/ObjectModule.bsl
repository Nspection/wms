
Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	Настройки = КомпоновщикНастроек.Настройки;
    ЭД = Настройки.ПараметрыДанных.Элементы.Найти("ДокументОснование");
    ЭД.Значение = ДокументОснование;
    ЭД.Использование = Истина;
КонецПроцедуры
