
&НаСервере
Процедура СохранитьНаСервере()
	СтруктураХраненияДанных=новый Структура;
	СтруктураХраненияДанных.Вставить("ДатаНачала",Отчет.ДатаНачала);
	СтруктураХраненияДанных.Вставить("ДатаОкончания",Отчет.ДатаОкончания);
	СтруктураХраненияДанных.Вставить("СтоимостьКороба",Отчет.СтоимостьКороба);
	СтруктураХраненияДанных.Вставить("СтоимостьКоробаПМУ",Отчет.СтоимостьКоробаПМУ);
	СтруктураХраненияДанных.Вставить("СтоимостьЯчейки",Отчет.СтоимостьЯчейки);
	СтруктураХраненияДанных.Вставить("СтоимостьЯчейкиРозницаНаборка",Отчет.СтоимостьЯчейкиРозницаНаборка);
	СтруктураХраненияДанных.Вставить("СтоимостьБутылкиНаборка",Отчет.СтоимостьБутылкиНаборка);
	СтруктураХраненияДанных.Вставить("СтоимостьБутылкиПМУНаборка",Отчет.СтоимостьБутылкиПМУНаборка);
	СтруктураХраненияДанных.Вставить("СтоимостьНаборки",Отчет.СтоимостьНаборки);
	СтруктураХраненияДанных.Вставить("СтоимостьНаборкиРозница",Отчет.СтоимостьНаборкиРозница);
	итWMSПривилегированныйМодуль.СохрнаитьНастройкиВХранилищеОбщихНастроек("ПланированиеНаборокWMSНастройки","ПланированиеНаборокWMSНастройки",СтруктураХраненияДанных,ПараметрыСеанса.ТекущийПользователь);
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	СохранитьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
СтруктураХраненияДанных=итWMSПривилегированныйМодуль.ЗагрузитьНастройкиИзХранилищаОбщихНастроек("ПланированиеНаборокWMSНастройки","ПланированиеНаборокWMSНастройки",ПараметрыСеанса.ТекущийПользователь);
Если ТипЗнч(СтруктураХраненияДанных)=Тип("Структура")  Тогда 
		ЗаполнитьЗначенияСвойств(Отчет,СтруктураХраненияДанных);
КонецЕсли;

КонецПроцедуры
