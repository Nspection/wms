
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
     Пк=ИмяКомпьютера();
	 Данные=итWMSПривилегированныйМодуль.ПолучитьНастройкиИзХранилищаПоСвойствам("ОбработкаСканированияВходаВыхода");
	 ПкВхода=Неопределено;
	 ПкВыхода=Неопределено;
	 Данные.ОбработкаСканированияВходаВыхода.Свойство("КомпьютерВхода",ПкВхода);
	 Данные.ОбработкаСканированияВходаВыхода.Свойство("КомпьютерВыхода",ПкВыхода);
	 Если ПкВхода=Пк Тогда
		 ОткрытьФорму("Обработка.ОбработкаСканированияВходаВыхода.Форма.ФормаВхода");
	 ИначеЕсли  ПкВыхода=Пк Тогда 
		 ОткрытьФорму("Обработка.ОбработкаСканированияВходаВыхода.Форма.ФормаВыхода");
	 Иначе 
		 ОткрытьФорму("Обработка.ОбработкаСканированияВходаВыхода.Форма.Форма");
     КонецЕсли;
КонецПроцедуры
