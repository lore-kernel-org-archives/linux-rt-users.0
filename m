From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: v3.14.73-rt77 build: 6 failures 10 warnings (v3.14.73-rt77)
Date: Fri, 15 Jul 2016 14:08:37 +0200
Message-ID: <20160715120837.GC11606@linutronix.de>
References: <E1bNvA3-0006oU-Ex@optimist>
 <6896332.PzHULJX9vz@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linaro-kernel@lists.linaro.org,
	Build bot for Mark Brown <broonie@kernel.org>,
	kernel-build-reports@lists.linaro.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6896332.PzHULJX9vz@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

+ Steven

* Arnd Bergmann | 2016-07-15 09:42:40 [+0200]:

>On Friday, July 15, 2016 5:55:39 AM CEST Build bot for Mark Brown wrote:
>> 
>>         arm64-allnoconfig
>> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
>> 
>>         arm64-allmodconfig
>> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
>> 
>>         arm-multi_v7_defconfig
>> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
>> 
>>         arm-allmodconfig
>> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
>> 
>>         arm-allnoconfig
>> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
>> 
>>         arm64-defconfig
>> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
>
>These all started failing yesterday with v3.14.72-rt76, before it was
>
>	v3.14.72-rt75 build: 0 failures 113 warnings (v3.14.72-rt75)
>
>	Arnd

Sebastian
