
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Данные=итWMSПривилегированныйМодуль.ПолучитьНастройкиИзХранилища();
	Если ТипЗнч(Данные)<>тип("Структура") тогда
		Отказ=Истина;
		Сообщить("Нет натстроек WMS");
		Возврат
	КонецЕсли;
	Если Данные.Свойство("ПапкаВнешнихWMS_Отчетов") тогда	
		СписокВнешнихОтчетов.Параметры.УстановитьЗначениеПараметра("ПапкаВнешнихWMSОтчетов",Данные.ПапкаВнешнихWMS_Отчетов);
		МассивРодителей=ПолучитьМассивРодителей(Данные.ПапкаВнешнихWMS_Отчетов);
		СписокВнешнихОтчетов.Параметры.УстановитьЗначениеПараметра("МассивРодителей",МассивРодителей);
	иначе
		СписокВнешнихОтчетов.Параметры.УстановитьЗначениеПараметра("ПапкаВнешнихWMSОтчетов",Справочники.ВнешниеОбработки.ПустаяСсылка());
		МассивРодителей=ПолучитьМассивРодителей(Справочники.ВнешниеОбработки.ПустаяСсылка());
		СписокВнешнихОтчетов.Параметры.УстановитьЗначениеПараметра("МассивРодителей",МассивРодителей);
	КонецЕсли;
КонецПроцедуры
&НаСервере
Функция ПолучитьМассивРодителей(ПапкаВнешнихWMSОтчетов)
	ПапкаОбработки=ПапкаВнешнихWMSОтчетов;
	МассивРодителей= новый Массив;
	Пока ПапкаОбработки.Родитель<>Справочники.ВнешниеОбработки.ПустаяСсылка() цикл
		МассивРодителей.Добавить(ПапкаОбработки.Родитель);
		ПапкаОбработки=ПапкаОбработки.Родитель;
	КонецЦикла;
	Возврат МассивРодителей;
	КонецФункции
&НаСервере
Функция  СписокВнешнихОтчетовВыборНаСервере(ВыбраннаяСтрока)	
	ДвоичныеДанные = ВыбраннаяСтрока.ХранилищеВнешнейОбработки.Получить();
	Возврат ДвоичныеДанные;
	КонецФункции

&НаКлиенте
Процедура СписокВнешнихОтчетовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Если не ВыбраннаяСтрока.ЭтоГруппа  Тогда
		СтандартнаяОбработка=Ложь;
		ДанныеОтчета=СписокВнешнихОтчетовВыборНаСервере(ВыбраннаяСтрока);
		ИмяФайла = ПолучитьИмяВременногоФайла();
		ДанныеОтчета.Записать(ИмяФайла);
		Обработка = ВнешниеОтчеты.Создать(ИмяФайла);
		Форма=Обработка.ПолучитьФорму(); 
		Форма.Открыть();
	КонецЕсли;
КонецПроцедуры
