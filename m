From: "Sarin, Suseelan" <suseelan@gmail.com>
Subject: Calculating latency using high resolution timer
Date: Wed, 9 Jun 2010 21:51:54 +0530
Message-ID: <AANLkTinCc-TibWfphYTZtXhDh2flvrcXNW_bO3SUetyV@mail.gmail.com>
References: <AANLkTikuWI08hHb2BdzicdEYKO4SdQlCL17gDQgqwrKz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37097 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0FIQWA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jun 2010 12:22:00 -0400
Received: by vws17 with SMTP id 17so2692155vws.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Jun 2010 09:21:59 -0700 (PDT)
In-Reply-To: <AANLkTikuWI08hHb2BdzicdEYKO4SdQlCL17gDQgqwrKz@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

My real-time program has a thread which needs to run at every 2ms. I
want to calculate the latency of this thread and I am using
clock_gettime for this. I am bit confused here that whether I can do
this. My doubt is, if the system is loaded to the extend that an RT
task can have considerable latency, can I trust the time read from the
high resolution timer of the system?

Also, with these measurements, I am seeing a ~5msec latency. Is there
a way I can exactly point out the reason for this latency?

Thanks in advance.

Regards,
Sarin
