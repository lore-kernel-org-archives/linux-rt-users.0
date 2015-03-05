From: Stanislav Meduna <stano@meduna.org>
Subject: Re: Highres timers broken on i.mx28 for CONFIG_HZ_PERIODIC
Date: Thu, 05 Mar 2015 18:54:52 +0100
Message-ID: <54F8986C.8020707@meduna.org>
References: <54615E89.7020902@meduna.org> <20150217140106.GO26177@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150217140106.GO26177@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 17.02.2015 15:01, Sebastian Andrzej Siewior wrote:

Hi,

>> something between 3.12.19(-rt30) and 3.12.31(-rt45) broke
>> hrtimers on (at least) i.MX28 for CONFIG_HZ_PERIODIC.
>> Switching to CONFIG_NO_HZ_IDLE restores them.
>>
>> Is this the expected behaviour or a regression?

> No, I don't think so. Did it get fixed in the meantime?

Looks OK again in 3.12.37(-rt51).

Sorry for the late answer, I was quite busy last weeks.

Thanks
-- 
                                       Stano
