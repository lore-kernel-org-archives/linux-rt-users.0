From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: i.MX6, PREEMPT-RT and interactive cpufreq governor
Date: Tue, 17 Feb 2015 09:35:24 +0100
Message-ID: <20150217083523.GA26177@linutronix.de>
References: <CAHQ1cqGy5gwEUFLS79y3=5_KmUEO+Q3ygDB-jXBZj5yN5xVqUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	asmirnov@kymetacorp.com, panos@kymetacorp.com
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHQ1cqGy5gwEUFLS79y3=5_KmUEO+Q3ygDB-jXBZj5yN5xVqUg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Andrey Smirnov | 2014-06-10 11:52:05 [-0700]:

>Eventually I am hoping to disable any sorts of frequency scaling or
>power management on our system, but I am still curious to know if that
>is a known issue patches for which exist. Does anyone has any leads/suggestions?

You need to breakout of the preempt_disable() region. However having
cpufreq running will have major effect on your latency so this might not
what you want in the long term.

>Thank you,
>Andrey Smirnov

Sebastian
