From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH tip v6 2/5] kbuild: Add option to turn incompatible
 pointer check into error
Date: Fri, 29 Jan 2016 13:17:43 +0100
Message-ID: <56AB5867.6020405@bmw-carit.de>
References: <1453992270-4688-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1453992270-4688-3-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-kbuild@vger.kernel.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1453992270-4688-3-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kbuild-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 01/28/2016 03:44 PM, Daniel Wagner wrote:
> +# enforce correct pointer usage
> +KBUILD_CFLAGS += $(call cc-option,-Werror=incompatible-pointer-types)
> +

As it turns out there are a few fallouts by that one. I'll send fixes
for it.
