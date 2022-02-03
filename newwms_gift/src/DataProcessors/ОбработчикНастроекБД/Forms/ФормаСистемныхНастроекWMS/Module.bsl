

&НаКлиенте
Процедура БлокироватьЯчейкиПриИнвентаризацииПриИзменении(Элемент)
	Если НаборкКонстант.БлокироватьЯчейкиПриИнвентаризации Тогда 
		НаборкКонстант.ВремяРазблокировкиЯчеекПриИнвентаризации=1;
	КонецЕсли;	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	СтруктураХраненияДанных=новый Структура;
	СтруктураХраненияДанных.Вставить("SSCCКарантина",SSCCКарантина);
	СтруктураХраненияДанных.Вставить("GTINКарантина",GTINКарантина);  
	СтруктураХраненияДанных.Вставить("CurrentDirectory",CurrentDirectory);
	СтруктураХраненияДанных.Вставить("CurrentDirectoryDll",CurrentDirectoryDll);
	СтруктураХраненияДанных.Вставить("ProcessorCapacity",ProcessorCapacity);

	итWMSПривилегированныйМодуль.СохранитьНастройкиВХранилище(СтруктураХраненияДанных);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
СтруктураХраненияДанных=итWMSПривилегированныйМодуль.ПолучитьНастройкиИзХранилищаПоСвойствам("SSCCКарантина,GTINКарантина,CurrentDirectory,CurrentDirectoryDll,ProcessorCapacity");
СтруктураХраненияДанных.Свойство("SSCCКарантина",SSCCКарантина); 
СтруктураХраненияДанных.Свойство("GTINКарантина",GTINКарантина); 
СтруктураХраненияДанных.Свойство("CurrentDirectory",CurrentDirectory); 
СтруктураХраненияДанных.Свойство("CurrentDirectoryDll",CurrentDirectoryDll);
СтруктураХраненияДанных.Свойство("ProcessorCapacity",ProcessorCapacity);
КонецПроцедуры


