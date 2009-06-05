From: Herman ten Brugge <hermantenbrugge@home.nl>
Subject: Re: Analyze sched_switch ftrace data with vcd viewer
Date: Fri, 05 Jun 2009 19:12:36 +0200
Message-ID: <4A295204.1010201@home.nl>
References: <4A281971.1040406@home.nl> <4A284185.4010606@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpq4.gn.mail.iss.as9143.net ([212.54.34.167]:54681 "EHLO
	smtpq4.gn.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752367AbZFERMg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Jun 2009 13:12:36 -0400
Received: from [212.54.34.134] (helo=smtp3.gn.mail.iss.as9143.net)
	by smtpq4.gn.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <hermantenbrugge@home.nl>)
	id 1MCcy5-0006Dt-CF
	for linux-rt-users@vger.kernel.org; Fri, 05 Jun 2009 19:12:37 +0200
Received: from cc717655-a.hnglo1.ov.home.nl ([82.75.52.184] helo=[192.168.123.3])
	by smtp3.gn.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <hermantenbrugge@home.nl>)
	id 1MCcy4-0004lV-Qh
	for linux-rt-users@vger.kernel.org; Fri, 05 Jun 2009 19:12:36 +0200
In-Reply-To: <4A284185.4010606@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  Carsten Emde wrote:
> Herman,
>
>   
>> I have written some code to convert the ascii sched_switch output to
>> vcd format (value change data). Now it is possible to view the context
>> switches in a vcd viewer. [..]
>>     
> That's superb, works great. Thanks a lot! If you agree, I would like to
> write a News Article on our Website on it.
>
> I have one question though: Under which license are you willing to make
> the source code available? GPL? If so, would you mind to put the GPL
> license text on top of your source code? It makes things easier.
>   
Great that some one likes the tool all ready. I forgot to  put the 
license in. The header of the
source should be:

/*
  sched_switch - Convert sched_switch ftrace data to vcd or matlab

   Copyright (C) 2009 Herman ten Brugge <hermantenbrugge@home.nl>

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
   USA */


    Herman.

