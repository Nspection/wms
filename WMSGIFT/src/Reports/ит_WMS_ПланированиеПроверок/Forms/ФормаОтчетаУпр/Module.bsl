
&НаСервере
Процедура СохранитьНаСервере()
	СтруктураДанных=новый Структура;
	СтруктураДанных.Вставить("ДатаНачала",Отчет.ДатаНачала);
	СтруктураДанных.Вставить("ДатаОкончания",Отчет.ДатаОкончания);
	СтруктураДанных.Вставить("АгрегацияПаллеты",Отчет.АгрегацияПаллеты);
	СтруктураДанных.Вставить("ФизическаяПроверка",Отчет.ФизическаяПроверка);
	СтруктураДанных.Вставить("АгрегацияКоробов",Отчет.АгрегацияКоробов);
	СтруктураДанных.Вставить("Опалечивание",Отчет.Опалечивание);
	СтруктураДанных.Вставить("ТаблицаНаценокПоКАВыгрузка",Отчет.ТаблицаНаценокПоКА.Выгрузить());
  	итWMSПривилегированныйМодуль.СохрнаитьНастройкиВХранилищеОбщихНастроек("итWMSПланированиеПроверок","итWMSПланированиеПроверок",СтруктураДанных,ПараметрыСеанса.ТекущийПользователь);

КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	СохранитьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	СтруктураХраненияДанных=итWMSПривилегированныйМодуль.ЗагрузитьНастройкиИзХранилищаОбщихНастроек("итWMSПланированиеПроверок","итWMSПланированиеПроверок",ПараметрыСеанса.ТекущийПользователь);
	Если ТипЗнч(СтруктураХраненияДанных)=Тип("Структура")  Тогда
		ЗаполнитьЗначенияСвойств(Отчет,СтруктураХраненияДанных);
		Если СтруктураХраненияДанных.Свойство("ТаблицаНаценокПоКАВыгрузка") Тогда 
			Отчет.ТаблицаНаценокПоКА.Загрузить(СтруктураХраненияДанных.ТаблицаНаценокПоКАВыгрузка);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры
