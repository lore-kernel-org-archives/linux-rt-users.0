From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] arm64: replace read_lock to rcu lock in call_step_hook
Date: Tue, 9 Feb 2016 11:08:15 -0500
Message-ID: <20160209110815.749c9e26@gandalf.local.home>
References: <1454971764-30720-1-git-send-email-yang.shi@linaro.org>
 <20160209145426.GR22874@arm.com>
 <20160209100758.69d9006f@gandalf.local.home>
 <20160209160442.GS22874@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yang Shi <yang.shi@linaro.org>, linaro-kernel@lists.linaro.org,
 linux-rt-users@vger.kernel.org, catalin.marinas@arm.com, bigeasy@linutronix.de,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160209160442.GS22874@arm.com>
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

On Tue, 9 Feb 2016 16:04:42 +0000
Will Deacon <will.deacon@arm.com> wrote:
 
> > The patch looks good to me. Do you want to take it through your tree?
> > 
> > It benefits mainline too as a rcu_read_lock() is more efficient than
> > rwlocks. Although I will say this is a slow path anyway.  
> 
> I was thinking that Catalin would queue it for 4.6 in the arm64 tree,
> since that's probably easiest in case any unlikely conflicts crop up.

Oh, OK.

That's fine. I just didn't want you to think that the RT folks were
going to pull it in for mainline.

-- Steve
