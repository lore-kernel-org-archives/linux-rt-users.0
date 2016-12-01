From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] arm: kprobe: replace patch_lock to raw lock
Date: Thu, 1 Dec 2016 15:13:46 +0100
Message-ID: <20161201141345.4xlceuchfkxyel75@linutronix.de>
References: <1478823475-15087-1-git-send-email-yang.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux@armlinux.org.uk, rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, linaro-kernel@lists.linaro.org
To: Yang Shi <yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478823475-15087-1-git-send-email-yang.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-11-10 16:17:55 [-0800], Yang Shi wrote:
> 
> Since patch_text_stop_machine() is called in stop_machine() which disables IRQ,
> sleepable lock should be not used in this atomic context, so replace patch_lock
> to raw lock.
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>

This can also go upstream.
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
