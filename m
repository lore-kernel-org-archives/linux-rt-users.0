From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH tip v5 2/5] kbuild: Add option to turn incompatible
 pointer check into error
Date: Wed, 27 Jan 2016 13:03:57 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601271300490.3886@nanos>
References: <1448890711-5812-1-git-send-email-daniel.wagner@bmw-carit.de> <1448890711-5812-3-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kbuild@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1448890711-5812-3-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kbuild-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 30 Nov 2015, Daniel Wagner wrote:
>  
> +ifdef CONFIG_ENABLE_ERR_TYPE_CHECK
> +KBUILD_CFLAGS += $(call cc-option,-Werror=incompatible-pointer-types)
> +endif

I don't see a value for making this configurable. If the compiler supports it,
we should use it. It already found a bug, so why would we make that optional?

Thanks,

	tglx
