From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch rfc] work-simple: Rename work-simple.[ch] to swork.[ch]
 for consistency
Date: Mon, 6 Jun 2016 10:52:48 +0200
Message-ID: <8e7b2ea1-ed08-f46a-c1bc-37b0fdca3b90@linutronix.de>
References: <20160603104424.GA18975@linutronix.de>
 <1465107370.4263.7.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465107370.4263.7.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 06/05/2016 08:16 AM, Mike Galbraith wrote:
> 
> The internal bits are already swork_blah, rename source to match. 
> 
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>

I don't mind the rename to keep things consistent. I merged the rename
into the original patch.

Sebastian
