
&НаКлиенте
Процедура Январь(Команда)
	Дата=Дата(Год,1,1);
	СнятьПометку();
	Элементы.Январь.Пометка=Истина;
	МесяцПометка=1;
	ДатаСтрокой=Формат(Дата,"ДФ='ММММ гггг'");
КонецПроцедуры

&НаКлиенте
Процедура Февраль(Команда)
	Дата=Дата(Год,2,1);
	СнятьПометку();
	Элементы.Февраль.Пометка=Истина;
	МесяцПометка=2;
	ДатаСтрокой=Формат(Дата,"ДФ='ММММ гггг'");
КонецПроцедуры

&НаКлиенте
Процедура Март(Команда)
	Дата=Дата(Год,3,1);
	СнятьПометку();
	Элементы.Март.Пометка=Истина;
	МесяцПометка=3;
	ДатаСтрокой=Формат(Дата,"ДФ='ММММ гггг'");
КонецПроцедуры

&НаКлиенте
Процедура Апрель(Команда)
	Дата=Дата(Год,4,1);
	СнятьПометку();
	Элементы.Апрель.Пометка=Истина;
	МесяцПометка=4;
	ДатаСтрокой=Формат(Дата,"ДФ='ММММ гггг'");
КонецПроцедуры

&НаКлиенте
Процедура Май(Команда)
	Дата=Дата(Год,5,1);
	СнятьПометку();
	Элементы.Май.Пометка=Истина;
	МесяцПометка=5;
	ДатаСтрокой=Формат(Дата,"ДФ='ММММ гггг'");
КонецПроцедуры

&НаКлиенте
Процедура Июнь(Команда)
	Дата=Дата(Год,6,1);
	СнятьПометку();
	Элементы.Июнь.Пометка=Истина;
	МесяцПометка=6;
	ДатаСтрокой=Формат(Дата,"ДФ='ММММ гггг'");
КонецПроцедуры

&НаКлиенте
Процедура Июль(Команда)
	Дата=Дата(Год,7,1);
	СнятьПометку();
	Элементы.Июль.Пометка=Истина;
	МесяцПометка=7;
	ДатаСтрокой=Формат(Дата,"ДФ='ММММ гггг'");
КонецПроцедуры

&НаКлиенте
Процедура Август(Команда)
	Дата=Дата(Год,8,1);
	СнятьПометку();
	Элементы.Август.Пометка=Истина;
	МесяцПометка=8;	
	ДатаСтрокой=Формат(Дата,"ДФ='ММММ гггг'");
КонецПроцедуры

&НаКлиенте
Процедура Сентябрь(Команда)
	Дата=Дата(Год,9,1);
	СнятьПометку();
	Элементы.Сентябрь.Пометка=Истина;
	МесяцПометка=9;
	ДатаСтрокой=Формат(Дата,"ДФ='ММММ гггг'");
КонецПроцедуры

&НаКлиенте
Процедура Октябрь(Команда)
	Дата=Дата(Год,10,1);
	СнятьПометку();
	Элементы.Октябрь.Пометка=Истина;
	МесяцПометка=10;
	ДатаСтрокой=Формат(Дата,"ДФ='ММММ гггг'");
КонецПроцедуры

&НаКлиенте
Процедура Ноябрь(Команда)
	Дата=Дата(Год,11,1);
	СнятьПометку();
	Элементы.Ноябрь.Пометка=Истина;
	МесяцПометка=11;	
	ДатаСтрокой=Формат(Дата,"ДФ='ММММ гггг'");
КонецПроцедуры

&НаКлиенте
Процедура Декабрь(Команда)
	Дата=Дата(Год,12,1);
	СнятьПометку();
	Элементы.Декабрь.Пометка=Истина;
	МесяцПометка=12;
	ДатаСтрокой=Формат(Дата,"ДФ='ММММ гггг'");
КонецПроцедуры

Процедура СнятьПометку()
	Если МесяцПометка=0 Тогда 
		Возврат
	КонецЕсли;	
	Если МесяцПометка =1 Тогда 
		Элементы.Январь.Пометка=Ложь;
	ИначеЕсли МесяцПометка=2 Тогда 
		Элементы.Февраль.Пометка=Ложь;
	ИначеЕсли МесяцПометка=3 Тогда 
		Элементы.Март.Пометка=Ложь;
	ИначеЕсли  МесяцПометка=4 Тогда 
		Элементы.Апрель.Пометка=Ложь;
	ИначеЕсли  МесяцПометка=5 Тогда 
		Элементы.Май.Пометка=Ложь;
	ИначеЕсли МесяцПометка=6 Тогда 
		Элементы.Июнь.Пометка=Ложь;
	ИначеЕсли  МесяцПометка=7 Тогда 
		Элементы.Июль.Пометка=Ложь;
	ИначеЕсли  МесяцПометка=8 Тогда 
		Элементы.Август.Пометка=Ложь;
	ИначеЕсли  МесяцПометка=9 Тогда 
		Элементы.Сентябрь.Пометка=Ложь;
	ИначеЕсли  МесяцПометка=10 Тогда 
		Элементы.Октябрь.Пометка=Ложь;
	ИначеЕсли  МесяцПометка=11 Тогда 
		Элементы.Ноябрь.Пометка=Ложь;
	Иначе
		Элементы.Декабрь.Пометка=Ложь;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Выбарть(Команда)
	ОповеститьОВыборе(Дата);
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	ЭтаФорма.Закрыть();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("Год") Тогда 
		Год=Параметры.Год;
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура ГодМинус(Команда)
	Год=Год-1;
КонецПроцедуры

&НаКлиенте
Процедура ГодПлюс(Команда)
	Год=Год+1;
КонецПроцедуры
