From: Daniel Wagner <wagi@monom.org>
Subject: Re: [ANNOUNCE] 3.18.7-rt1
Date: Fri, 27 Feb 2015 07:40:05 +0100
Message-ID: <54F01145.4050408@monom.org>
References: <20150216111822.GA21649@linutronix.de> <54E2FDD8.8090008@monom.org> <20150219103601.7e40d0af@tor.valhalla.alchemy.lu> <20150225135501.GA6823@linutronix.de> <20150226084850.GA12992@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Joakim Hernberg <jhernberg@alchemy.lu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150226084850.GA12992@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian

On 02/26/2015 09:48 AM, Sebastian Andrzej Siewior wrote:
> * Sebastian Andrzej Siewior | 2015-02-25 14:55:01 [+0100]:
> +
> +static int thermal_notify_work_init(void)
> +{
> +	int err;
> +
> +	err = swork_get();
> +	if (!err)
> +		return err;

It think this should be:

	if (err)
		return err;


cheers,
daniel
