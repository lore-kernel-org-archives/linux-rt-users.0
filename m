From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Highres timers broken on i.mx28 for CONFIG_HZ_PERIODIC
Date: Tue, 17 Feb 2015 15:01:06 +0100
Message-ID: <20150217140106.GO26177@linutronix.de>
References: <54615E89.7020902@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54615E89.7020902@meduna.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Stanislav Meduna | 2014-11-11 01:55:37 [+0100]:

>Hi,
Hi,

>something between 3.12.19(-rt30) and 3.12.31(-rt45) broke
>hrtimers on (at least) i.MX28 for CONFIG_HZ_PERIODIC.
>Switching to CONFIG_NO_HZ_IDLE restores them.
>
>Is this the expected behaviour or a regression?
No, I don't think so. Did it get fixed in the meantime? But you if have
two v3.12 based kernel you could bisect to the issue.

Sebastian
