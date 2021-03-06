
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Макет=ПолучитьИзначальныйМакет();
	Макет.Параметры.Расшифровка = Истина; // чтобы работала расшифровка	
	ТабличныйДокумент.Вывести(Макет);
КонецПроцедуры

&НаКлиенте
Процедура ТабличныйДокументОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка, ДополнительныеПараметры)
	СтандартнаяОбработка = Ложь;
	
	ТекущаяОбласть    = ТабличныйДокумент.ТекущаяОбласть;
	Макет=ПолучитьИзначальныйМакет();
	ОбластьКодЧисловой         = Макет.Области.КодЧисловой;
	ОбластьНаименованиеКраткое = Макет.Области.НаименованиеКраткое;
	ОбластьНаименованиеПолное  = Макет.Области.НаименованиеПолное;
	ОбластьКодАльфа2           = Макет.Области.КодАльфа2;
	
		
	КодЧисловой         = ТабличныйДокумент.Область(ТекущаяОбласть.Верх, ОбластьКодЧисловой.        Лево, ТекущаяОбласть.Низ, ОбластьКодЧисловой.        Право).Текст;
	НаименованиеКраткое = ТабличныйДокумент.Область(ТекущаяОбласть.Верх, ОбластьНаименованиеКраткое.Лево, ТекущаяОбласть.Низ, ОбластьНаименованиеКраткое.Право).Текст;
	НаименованиеПолное  = ТабличныйДокумент.Область(ТекущаяОбласть.Верх, ОбластьНаименованиеПолное. Лево, ТекущаяОбласть.Низ, ОбластьНаименованиеПолное. Право).Текст;
	КодАльфа2           = ТабличныйДокумент.Область(ТекущаяОбласть.Верх, ОбластьКодАльфа2.          Лево, ТекущаяОбласть.Низ, ОбластьКодАльфа2.          Право).Текст;
		
	ОповеститьОВыборе(новый Структура("КодЧисловой,НаименованиеКраткое,НаименованиеПолное,КодАльфа2",КодЧисловой,НаименованиеКраткое,НаименованиеПолное,КодАльфа2));
	КонецПроцедуры
&НаСервере
Функция ПолучитьИзначальныйМакет()
		Возврат Справочники.КлассификаторСтранМира.ПолучитьМакет("КлассификаторСтранМира");
		КонецФункции
