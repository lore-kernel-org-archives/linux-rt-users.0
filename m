From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [RFC v0 0/3] Simple wait queue support
Date: Tue, 11 Aug 2015 08:24:49 +0200
Message-ID: <55C99531.5050409@bmw-carit.de>
References: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<paul.gortmaker@windriver.com>, <peterz@infradead.org>,
	<bigeasy@linutronix.de>, <tglx@linutronix.de>,
	<paulmck@linux.vnet.ibm.com>, <rostedt@goodmis.org>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Clark,

On 08/05/2015 03:30 PM, Daniel Wagner wrote:
> It's a while since the last attempt by Paul to get simple wait ready
> for mainline [1]. At the last realtime workshop it was discussed how
> the swait implementation could be made preempt aware. Peter posted an
> untested version of it here [2].
> 
> In order to test it, I used Paul's two patches which makes completion
> and rcu using swait instead of wait. Some small renamings were
> necessary to get it working, e.g. s/swait_head/swait_queue_head/.

I have setup a git tree with the patches as you have requested:

https://git.kernel.org/cgit/linux/kernel/git/wagi/linux.git/log/?h=swait

If you have your list -> hlist patch ready I'll gladly test it.

cheers,
daniel
