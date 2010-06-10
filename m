From: "Sarin, Suseelan" <suseelan@gmail.com>
Subject: Re: Calculating latency using high resolution timer
Date: Thu, 10 Jun 2010 11:43:54 +0530
Message-ID: <AANLkTikQ5Arhc-msaILLa1oFPbTHbg7yXxSKp3F-T7cM@mail.gmail.com>
References: <AANLkTikuWI08hHb2BdzicdEYKO4SdQlCL17gDQgqwrKz@mail.gmail.com>
	<AANLkTinCc-TibWfphYTZtXhDh2flvrcXNW_bO3SUetyV@mail.gmail.com>
	<alpine.LFD.2.00.1006092028280.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56524 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab0FJGNz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jun 2010 02:13:55 -0400
Received: by gwj15 with SMTP id 15so542915gwj.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Jun 2010 23:13:54 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1006092028280.2933@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>> this. My doubt is, if the system is loaded to the extend that an RT
>> task can have considerable latency, can I trust the time read from the
>> high resolution timer of the system?
>
> Yes, it's accurate. cyclictest relies on that as well.
>
>> Also, with these measurements, I am seeing a ~5msec latency. Is there
>> a way I can exactly point out the reason for this latency?
>
> Tracing. See cyclictest.c for how that's done.

Thank you. I will check the cyclic test code and get back.
