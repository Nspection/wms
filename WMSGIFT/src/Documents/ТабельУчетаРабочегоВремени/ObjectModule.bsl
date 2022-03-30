#Если Сервер Тогда
Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	ДатаОтсчета=ДатаНачалаПериода;
	ДанныеТабельногоУчетаРабочегоВремениСотрудников=Движения.ДанныеТабельногоУчетаРабочегоВремениСотрудников;
	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Очистить();
	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Записать();
	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Записывать=Истина;
	Для Каждого стр Из ДанныеОВремени Цикл
		Пока ДатаОтсчета<=ДатаОкончанияПериода Цикл
			ДеньМесяца=День(ДатаОтсчета);
			ВидВремени= стр["ВидВремени"+Строка(ДеньМесяца)];
			Если ВидВремени.Пустая() Тогда 
				ДатаОтсчета=ДатаОтсчета+24*60*60;
				Продолжить;
			КонецЕсли;	
			НоваяЗапись=ДанныеТабельногоУчетаРабочегоВремениСотрудников.Добавить();
			НоваяЗапись.Регистратор=Ссылка;
			НоваяЗапись.Организация=Организация;
			НоваяЗапись.Период=Дата;	
			НоваяЗапись.Сотрудник=стр.Сотрудник;
			НоваяЗапись.ПериодРегистрации=ДатаОтсчета;
			НоваяЗапись.ВидУчетаВремени=стр["ВидВремени"+Строка(ДеньМесяца)];
			НоваяЗапись.Часы=стр["Часов"+Строка(ДеньМесяца)];
			ДатаОтсчета=ДатаОтсчета+24*60*60;
		КонецЦикла;	
	КонецЦикла;
	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Записать();
КонецПроцедуры

#КонецЕсли
