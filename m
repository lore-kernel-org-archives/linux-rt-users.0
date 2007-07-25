From: John Sigler <linux.kernel@free.fr>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Wed, 25 Jul 2007 17:46:28 +0200
Message-ID: <46A77054.8040203@free.fr>
References: <469600F7.3060603@free.fr> <20070725133835.GA17616@elte.hu> <46A758B5.9070602@free.fr> <200707251728.00207.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:50196 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbXGYPqc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 11:46:32 -0400
In-Reply-To: <200707251728.00207.fzu@wemgehoertderstaat.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Karsten Wiese wrote:

> John Sigler wrote:
> 
>> Is there some form of priority inheritance? Does the IRQ handler get a 
>> priority boost if a high priority task is waiting for it?
> 
> No. But that would be "nice to have".

No to the first question? to the second question? or to both? :-)

In kernel/futex.c does "PI" stand for Priority Inheritance?

e.g.

/*
  * Priority Inheritance state:
  */
struct futex_pi_state {
	/*
	 * list of 'owned' pi_state instances - these have to be
	 * cleaned up in do_exit() if the task exits prematurely:
	 */
	struct list_head list;

	/*
	 * The PI object:
	 */
	struct rt_mutex pi_mutex;

	struct task_struct *owner;
	atomic_t refcount;

	union futex_key key;
};
