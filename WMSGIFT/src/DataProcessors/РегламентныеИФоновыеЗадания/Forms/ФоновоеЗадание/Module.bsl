

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий формы
//

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Отказ от инициализации, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметры.СвойстваФоновогоЗадания = Неопределено Тогда
		СвойстваФоновогоЗадания = РегламентныеЗаданияСервер.ПолучитьСвойстваФоновогоЗадания(Параметры.Идентификатор);
		Если СвойстваФоновогоЗадания = Неопределено Тогда
			ВызватьИсключение(НСтр("ru = 'Фоновое задание не найдено.'"));
		КонецЕсли;
		СообщенияПользователюИОписаниеИнформацииОбОшибке = РегламентныеЗаданияСервер.СообщенияИОписанияОшибокФоновогоЗадания(Параметры.Идентификатор);
		Если ЗначениеЗаполнено(СвойстваФоновогоЗадания.ИдентификаторРегламентногоЗадания) Тогда
			ИдентификаторРегламентногоЗадания = СвойстваФоновогоЗадания.ИдентификаторРегламентногоЗадания;
			НаименованиеРегламентногоЗадания = РегламентныеЗаданияСервер.ПредставлениеРегламентногоЗадания(СвойстваФоновогоЗадания.ИдентификаторРегламентногоЗадания);
		Иначе
			НаименованиеРегламентногоЗадания  = РегламентныеЗаданияСервер.ТекстНеОпределено();
			ИдентификаторРегламентногоЗадания = РегламентныеЗаданияСервер.ТекстНеОпределено();
		КонецЕсли;
	Иначе
		СвойстваФоновогоЗадания = Параметры.СвойстваФоновогоЗадания;
		ЗаполнитьЗначенияСвойств(ЭтаФорма, СвойстваФоновогоЗадания, "СообщенияПользователюИОписаниеИнформацииОбОшибке, ИдентификаторРегламентногоЗадания, НаименованиеРегламентногоЗадания");
	КонецЕсли;
	ЗаполнитьЗначенияСвойств(ЭтаФорма, СвойстваФоновогоЗадания, "Идентификатор, Ключ, Наименование, Начало, Конец, Расположение, Состояние, ИмяМетода");
	
КонецПроцедуры

