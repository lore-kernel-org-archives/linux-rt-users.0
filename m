From: Jeremy Jongepier <jeremy@autostatic.com>
Subject: Re: [ANNOUNCE] 2.6.33.9-rt31
Date: Sat, 16 Apr 2011 10:35:42 +0200
Message-ID: <4DA954DE.4060907@autostatic.com>
References: <alpine.LFD.2.00.1104111723020.4501@localhost6.localdomain6>	<497D1168CB2F407F9005845B39FEF144@e1705>	<alpine.LFD.2.00.1104111806021.4501@localhost6.localdomain6> <BANLkTin594W7qFUhmBAAGwSfwaCEqCX+hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpq2.tb.mail.iss.as9143.net ([212.54.42.165]:54147 "EHLO
	smtpq2.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751854Ab1DPIft (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Apr 2011 04:35:49 -0400
Received: from [212.54.42.137] (helo=smtp6.tb.mail.iss.as9143.net)
	by smtpq2.tb.mail.iss.as9143.net with esmtp (Exim 4.71)
	(envelope-from <jeremy@autostatic.com>)
	id 1QB0yp-0001dz-JL
	for linux-rt-users@vger.kernel.org; Sat, 16 Apr 2011 10:35:47 +0200
Received: from 5ed1002c.cm-7-2a.dynamic.ziggo.nl ([94.209.0.44] helo=[192.168.1.36])
	by smtp6.tb.mail.iss.as9143.net with esmtp (Exim 4.71)
	(envelope-from <jeremy@autostatic.com>)
	id 1QB0yk-00068V-Te
	for linux-rt-users@vger.kernel.org; Sat, 16 Apr 2011 10:35:42 +0200
In-Reply-To: <BANLkTin594W7qFUhmBAAGwSfwaCEqCX+hA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/15/2011 05:02 PM, dashesy wrote:
> Thanks, works great on 64-bit Ubuntu (Selected SMP and Core i7 and
> minimal ACPI), the only problem I have is with two displays and
> nouveau driver.

Which is exactly the same issue I am having. This is because the nouveau 
driver is crippled since rt29.

Best,

Jeremy
