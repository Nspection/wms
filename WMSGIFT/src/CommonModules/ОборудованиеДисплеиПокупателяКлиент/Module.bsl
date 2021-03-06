
#Область ПрограммныйИнтерфейс

// Заполняет структуру дополнительных параметров операции на Оборудовании.
// 
// Параметры:
//  СтрокиТекста - Строка - строки текста для отображения.
//  ЗначениеQRКода - Неопределено - Значение QRКода
// 
// Возвращаемое значение:
//  Структура. -Параметры операции дисплей покупателя
Функция ПараметрыОперацииДисплейПокупателя(СтрокиТекста = "", ЗначениеQRКода = Неопределено) Экспорт
	
	Результат = Новый Структура();
	Результат.Вставить("СтрокиТекста", СтрокиТекста);
	Результат.Вставить("ЗначениеQRКода"); // Строка - значение QR кода
	Результат.Вставить("КартинкаQRКода"); // Строка - строка с base64 представлением png картинки логотипа.
	Возврат Результат;
	
КонецФункции

// Подключенные дисплеи покупателя выводят QR код.
// 
// Возвращаемое значение:
//  Булево
//
Функция ПодключенныеДисплеиПокупателяВыводятQRКод() Экспорт
	
	Результат = Ложь;
	
	ПодключенныеУстройства = МенеджерОборудованияКлиент.ПолучитьПодключенныеУстройства("ДисплейПокупателя");
	Если ПодключенныеУстройства.Количество() > 0 Тогда
		Для Каждого Устройство Из ПодключенныеУстройства Цикл
			Если Устройство.ДисплейОтображаетQRКод Или Устройство.ДисплейОтображаетГрафику Тогда
				Результат = Истина;
				Прервать;
			КонецЕсли;
		КонецЦикла
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Начать вывод тестовых строк на подключенные дисплеи покупателя.
//
// Параметры:
//   ОповещениеПриЗавершении - ОписаниеОповещения - оповещение при завершении.
//   ИдентификаторКлиента    - ФормаКлиентскогоПриложения -идентификатор формы.
//   ИдентификаторУстройства - СправочникСсылка.ПодключаемоеОборудование - идентификатор устройства, если неопределенно - будет выведено на все.
//   ПараметрыОперации       - Структура - параметры выполнения операции.
//   ДополнительныеПараметры - Структура - дополнительные команды.
//
Процедура НачатьВыводИнформацииНаДисплейПокупателя(ОповещениеПриЗавершении, ИдентификаторКлиента, ИдентификаторУстройства, ПараметрыОперации, ДополнительныеПараметры = Неопределено) Экспорт
	
	ПараметрыВыполнениеКоманды = МенеджерОборудованияКлиентСервер.ПараметрыВыполнениеКоманды("DisplayText", , ДополнительныеПараметры, Ложь, Ложь);
	
	Если ИдентификаторУстройства = Неопределено Или  ПустаяСтрока(ИдентификаторУстройства) Тогда
		
		ПодключенныеУстройства = МенеджерОборудованияКлиент.ПолучитьПодключенныеУстройства("ДисплейПокупателя");
		Если ПодключенныеУстройства.Количество() > 0 Тогда
			Для Каждого Устройство Из ПодключенныеУстройства Цикл
				МенеджерОборудованияКлиент.НачатьВыполнениеКоманды(ОповещениеПриЗавершении, ИдентификаторКлиента, Устройство.Ссылка, 
					ПараметрыОперации, ПараметрыВыполнениеКоманды);
			КонецЦикла
		КонецЕсли;
		
	Иначе
		МенеджерОборудованияКлиент.НачатьВыполнениеКоманды(ОповещениеПриЗавершении, ИдентификаторКлиента, ИдентификаторУстройства, 
			ПараметрыОперации, ПараметрыВыполнениеКоманды);
	КонецЕсли;
	
КонецПроцедуры

// Начать вывод QR-кода на подключенные дисплеи покупателя.
//
// Параметры:
//   ОповещениеПриЗавершении - ОписаниеОповещения - оповещение при завершении.
//   ИдентификаторКлиента    - ФормаКлиентскогоПриложения -идентификатор формы.
//   ИдентификаторУстройства - СправочникСсылка.ПодключаемоеОборудование - идентификатор устройства, если неопределенно - будет выведено на все
//   ПараметрыОперации       - Структура - параметры выполнения операции.
//   ДополнительныеПараметры - Структура - дополнительные команды.
//
Процедура НачатьВыводQRКодаНаДисплейПокупателя(ОповещениеПриЗавершении, ИдентификаторКлиента, ИдентификаторУстройства, ПараметрыОперации, ДополнительныеПараметры = Неопределено) Экспорт
	
	ПараметрыВыполнениеКоманды = МенеджерОборудованияКлиентСервер.ПараметрыВыполнениеКоманды("DisplayQRCode", , ДополнительныеПараметры, Ложь, Ложь);
	
	Если ИдентификаторУстройства = Неопределено Или  ПустаяСтрока(ИдентификаторУстройства) Тогда
		
		ПодключенныеУстройства = МенеджерОборудованияКлиент.ПолучитьПодключенныеУстройства("ДисплейПокупателя");
		Если ПодключенныеУстройства.Количество() > 0 Тогда
			Для Каждого Устройство Из ПодключенныеУстройства Цикл
				МенеджерОборудованияКлиент.НачатьВыполнениеКоманды(ОповещениеПриЗавершении, ИдентификаторКлиента, Устройство.Ссылка, 
					ПараметрыОперации, ПараметрыВыполнениеКоманды);
			КонецЦикла
		КонецЕсли;
		
	Иначе
		МенеджерОборудованияКлиент.НачатьВыполнениеКоманды(ОповещениеПриЗавершении, ИдентификаторКлиента, ИдентификаторУстройства, 
			ПараметрыОперации, ПараметрыВыполнениеКоманды);
	КонецЕсли;
	
КонецПроцедуры

// Начать очистку подключенных дисплеев покупателя.
//
// Параметры:
//   ОповещениеПриЗавершении - ОписаниеОповещения - оповещение при завершении.
//   ИдентификаторКлиента    - ФормаКлиентскогоПриложения -идентификатор формы.
//   ИдентификаторУстройства - СправочникСсылка.ПодключаемоеОборудование - идентификатор устройства, если неопределенно - будет предложен выбор.
//   ПараметрыОперации       - Структура - параметры выполнения операции.
//   ДополнительныеПараметры - Структура - дополнительные команды.
//
Процедура НачатьОчисткуДисплеяПокупателя(ОповещениеПриЗавершении, ИдентификаторКлиента, ИдентификаторУстройства = Неопределено, ПараметрыОперации = Неопределено, ДополнительныеПараметры = Неопределено) Экспорт
	
	ПараметрыВыполнениеКоманды = МенеджерОборудованияКлиентСервер.ПараметрыВыполнениеКоманды("ClearText", , ДополнительныеПараметры, Ложь, Ложь);
	
	Если ИдентификаторУстройства = Неопределено Или ПустаяСтрока(ИдентификаторУстройства) Тогда
		
		ПодключенныеУстройства = МенеджерОборудованияКлиент.ПолучитьПодключенныеУстройства("ДисплейПокупателя");
		Если ПодключенныеУстройства.Количество() > 0 Тогда
			Для Каждого Устройство Из ПодключенныеУстройства Цикл
				МенеджерОборудованияКлиент.НачатьВыполнениеКоманды(ОповещениеПриЗавершении, ИдентификаторКлиента, Устройство.Ссылка, 
					ПараметрыОперации, ПараметрыВыполнениеКоманды);
			КонецЦикла
		КонецЕсли;
		
	Иначе
		МенеджерОборудованияКлиент.НачатьВыполнениеКоманды(ОповещениеПриЗавершении, ИдентификаторКлиента, ИдентификаторУстройства, 
			ПараметрыОперации, ПараметрыВыполнениеКоманды);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
