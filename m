From: Remy Bohmer <linux@bohmer.net>
Subject: Re: Minor page faults from pthread_create()
Date: Sat, 7 Jan 2012 19:28:44 +0100
Message-ID: <CANqCtQKYdzaHedPLeDHdg+aBAD5AQ2ESF0MuD1o9x7M3BnKadw@mail.gmail.com>
References: <4F075DA5.1070307@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47974 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab2AGS2q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Jan 2012 13:28:46 -0500
Received: by bkcjm19 with SMTP id jm19so685087bkc.19
        for <linux-rt-users@vger.kernel.org>; Sat, 07 Jan 2012 10:28:44 -0800 (PST)
In-Reply-To: <4F075DA5.1070307@drcomp.erfurt.thur.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2012/1/6 Adrian Knoth <adi@drcomp.erfurt.thur.de>:
> I was wondering why pthread_create() should cause minor page faults when
> there is a pre-allocated pre-faulted 100MB memory pool.

That pre-allocated block of memory is used by Glibc for its malloc routines.
While doing a pthread_create() you go to the kernel. Inside the kernel
many functions allocate memory as well. This is outside the control of
the C-library.
Probably some function inside the kernel allocates this memory and
uses it, resulting in these page-faults.
One example is allocating memory for the stack.

Kind regards,

Remy
