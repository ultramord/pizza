-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Окт 16 2017 г., 06:26
-- Версия сервера: 10.1.13-MariaDB
-- Версия PHP: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `pizzadb`
--

-- --------------------------------------------------------

--
-- Структура таблицы `pizza_booking`
--

CREATE TABLE `pizza_booking` (
  `booking_id` int(11) NOT NULL,
  `user_surname` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_patronymic` varchar(255) NOT NULL,
  `user_phone` int(11) NOT NULL,
  `user_street` varchar(255) NOT NULL,
  `user_house_number` varchar(10) NOT NULL,
  `user_apartment_number` int(11) NOT NULL,
  `user_entrance_number` int(11) NOT NULL,
  `user_floor_number` int(11) NOT NULL,
  `user_intercom` int(11) NOT NULL,
  `operator_id` int(11) DEFAULT '0',
  `carrier_id` int(11) NOT NULL DEFAULT '0',
  `booking_status` int(11) NOT NULL,
  `booking_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pizza_booking`
--

INSERT INTO `pizza_booking` (`booking_id`, `user_surname`, `user_name`, `user_patronymic`, `user_phone`, `user_street`, `user_house_number`, `user_apartment_number`, `user_entrance_number`, `user_floor_number`, `user_intercom`, `operator_id`, `carrier_id`, `booking_status`, `booking_date`) VALUES
(1, 'Ефимов', 'Алексей', 'Павлович', 82415612, 'Ранжурова', '5', 1, 1, 1, 0, 3, 4, 2, '2017-09-25 07:02:00'),
(2, 'Иванов', 'Андрей', 'Сергеевич', 364456, 'Партизанская', '47', 1, 1, 1, 0, 3, 0, 2, '2017-10-03 06:23:00');

-- --------------------------------------------------------

--
-- Структура таблицы `pizza_booking_connect`
--

CREATE TABLE `pizza_booking_connect` (
  `booking_connect_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `booking_connect_cook_id` int(11) NOT NULL DEFAULT '0',
  `booking_connect_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pizza_booking_connect`
--

INSERT INTO `pizza_booking_connect` (`booking_connect_id`, `booking_id`, `goods_id`, `booking_connect_cook_id`, `booking_connect_status`) VALUES
(1, 1, 5, 2, 3),
(2, 1, 5, 2, 2),
(3, 1, 4, 2, 3),
(4, 1, 4, 2, 3),
(5, 2, 4, 2, 2),
(6, 2, 5, 2, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `pizza_carrier`
--

CREATE TABLE `pizza_carrier` (
  `carrier_id` int(11) NOT NULL,
  `carrier_name` varchar(255) NOT NULL,
  `carrier_surname` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pizza_carrier`
--

INSERT INTO `pizza_carrier` (`carrier_id`, `carrier_name`, `carrier_surname`, `user_id`) VALUES
(1, 'ИмяКурьера', 'ФамилияКурьера', 4);

-- --------------------------------------------------------

--
-- Структура таблицы `pizza_cook`
--

CREATE TABLE `pizza_cook` (
  `cook_id` int(11) NOT NULL,
  `cook_name` varchar(255) NOT NULL,
  `cook_surname` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pizza_cook`
--

INSERT INTO `pizza_cook` (`cook_id`, `cook_name`, `cook_surname`, `user_id`) VALUES
(1, 'Андрей', 'Иванов', 2),
(2, 'Повар2', 'Повар2', 5);

-- --------------------------------------------------------

--
-- Структура таблицы `pizza_goods`
--

CREATE TABLE `pizza_goods` (
  `goods_id` int(11) NOT NULL,
  `goods_name` varchar(255) NOT NULL,
  `goods_price` double NOT NULL,
  `goods_img` varchar(255) NOT NULL,
  `goods_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pizza_goods`
--

INSERT INTO `pizza_goods` (`goods_id`, `goods_name`, `goods_price`, `goods_img`, `goods_status`) VALUES
(4, 'Пепперони', 350, '1505998500_ce61db9628122e46600f7cf4e2a1a9d4.jpg', 1),
(5, 'Греческая', 405, '1505998631_79039ca01e0e2265b8e1e01d4d74dcc7.jpg', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `pizza_operator`
--

CREATE TABLE `pizza_operator` (
  `operator_id` int(11) NOT NULL,
  `operator_name` varchar(255) NOT NULL,
  `operator_surname` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pizza_operator`
--

INSERT INTO `pizza_operator` (`operator_id`, `operator_name`, `operator_surname`, `user_id`) VALUES
(1, 'ИмяОператора', 'ФамилияОператора', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `pizza_user`
--

CREATE TABLE `pizza_user` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(32) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pizza_user`
--

INSERT INTO `pizza_user` (`user_id`, `username`, `password`, `status`) VALUES
(1, 'admin', 'admin', 1),
(2, 'cook', 'cook', 4),
(3, 'operator', 'oper', 2),
(4, 'carrier', 'carrier', 3),
(5, 'cook1', 'cook', 4);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `pizza_booking`
--
ALTER TABLE `pizza_booking`
  ADD PRIMARY KEY (`booking_id`);

--
-- Индексы таблицы `pizza_booking_connect`
--
ALTER TABLE `pizza_booking_connect`
  ADD PRIMARY KEY (`booking_connect_id`);

--
-- Индексы таблицы `pizza_carrier`
--
ALTER TABLE `pizza_carrier`
  ADD PRIMARY KEY (`carrier_id`);

--
-- Индексы таблицы `pizza_cook`
--
ALTER TABLE `pizza_cook`
  ADD PRIMARY KEY (`cook_id`);

--
-- Индексы таблицы `pizza_goods`
--
ALTER TABLE `pizza_goods`
  ADD PRIMARY KEY (`goods_id`);

--
-- Индексы таблицы `pizza_operator`
--
ALTER TABLE `pizza_operator`
  ADD PRIMARY KEY (`operator_id`);

--
-- Индексы таблицы `pizza_user`
--
ALTER TABLE `pizza_user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `pizza_booking`
--
ALTER TABLE `pizza_booking`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `pizza_booking_connect`
--
ALTER TABLE `pizza_booking_connect`
  MODIFY `booking_connect_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблицы `pizza_carrier`
--
ALTER TABLE `pizza_carrier`
  MODIFY `carrier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `pizza_cook`
--
ALTER TABLE `pizza_cook`
  MODIFY `cook_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `pizza_goods`
--
ALTER TABLE `pizza_goods`
  MODIFY `goods_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблицы `pizza_operator`
--
ALTER TABLE `pizza_operator`
  MODIFY `operator_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `pizza_user`
--
ALTER TABLE `pizza_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
