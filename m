From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] arm: kprobe: replace patch_lock to raw lock
Date: Thu, 1 Dec 2016 15:11:39 +0100
Message-ID: <20161201141138.css266nzcutzfapw@linutronix.de>
References: <1478823475-15087-1-git-send-email-yang.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org,
 linux@armlinux.org.uk, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
To: Yang Shi <yang.shi@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1478823475-15087-1-git-send-email-yang.shi@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-11-10 16:17:55 [-0800], Yang Shi wrote:
> 
> Since patch_text_stop_machine() is called in stop_machine() which disables IRQ,
> sleepable lock should be not used in this atomic context, so replace patch_lock
> to raw lock.

I am taking this one. Thank you.
We have jump_labels() deactivated on ARM because stop_machine() may
cause latencies at runtime. kprobe and kgdb is used by the user on
purpose (and not because he changed some sched setting) I think we are
fine. I am going to document this.

> Signed-off-by: Yang Shi <yang.shi@linaro.org>

Sebastian
