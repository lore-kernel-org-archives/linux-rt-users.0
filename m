From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Any issue to be considered if ethernet send buffer is modified
Date: Fri, 11 Oct 2013 11:51:23 +0200
Message-ID: <20131011095123.GB6983@linutronix.de>
References: <CALJd4cb9aZF=jzbYiAf518KW-hS+QR4u0JDHefmR5Q4DipOuPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-newbie@vger.kernel.org,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Ashoka K <ashok.vinu@gmail.com>
Return-path: <linux-newbie-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALJd4cb9aZF=jzbYiAf518KW-hS+QR4u0JDHefmR5Q4DipOuPw@mail.gmail.com>
Sender: linux-newbie-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Ashoka K | 2013-08-30 13:51:14 [+0530]:

>Hi,
Hi,

>I use embedded system with 2.6.33, Preempt patch. To reduce the
>latency of sending data by our application, the ethernet send buffer
>is modified with setsockopt().
>
>Before modification the send buffer size by default was shown as 16384 bytes.
>But on proc system value shown is different, both default and max are same:
>/proc/sys/net/core/wmem_default = 108544
>
>Eventhough the above value is not modified, why the default is shown
>as 16384 instead 108544. Did kernel change these values during sending
>traffic ?
>
>If send buffer is set by setsockopt(), is this value modified by
>kernel during run time?

Try to grep for sysctl_wmem_default. Atleast on v3.10 this value is
initialized at compile time and only updated via sysctl and not by the
kernel.

>AK

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-newbie" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.linux-learn.org/faqs
