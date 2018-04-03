From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 1/3] alarmtimer: Prevent live lock in alarm_cancel()
Date: Tue, 3 Apr 2018 20:32:36 +0200
Message-ID: <c248f69e-1016-e7ec-64c2-1b8756524a49@monom.org>
References: <20180328100746.18668-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, stable-rt@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180328100746.18668-1-bigeasy@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian,

On 03/28/2018 12:07 PM, Sebastian Andrzej Siewior wrote:
> If alarm_try_to_cancel() requires a retry, then depending on the
> priority setting the retry loop might prevent timer callback completion
> on RT. Prevent that by waiting for completion on RT, no change for a
> non RT kernel.
> 
> Cc: stable-rt@vger.kernel.org

How relevant is this serie for trees before eae1c4ae275f ("posix-timers: 
Make use of cancel/arm callbacks")? Patch #2 seems to depend on that 
change which was added in v4.12.

Thanks,
Daniel
