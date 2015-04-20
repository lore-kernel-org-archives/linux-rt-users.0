From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Mon, 20 Apr 2015 15:20:38 -0300
Message-ID: <55354376.9080303@bristot.me>
References: <20150416183812.GA5571@linux.vnet.ibm.com>	<20150418130340.GA26931@gmail.com>	<20150418133444.GD23685@linux.vnet.ibm.com>	<20150418143238.GA2337@gmail.com>	<20150419020541.GA5561@linux.vnet.ibm.com>	<20150420113554.598e503f@sluggy>	<20150420170902.GU5561@linux.vnet.ibm.com> <20150420125922.35243e90@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
	akpm@linux-foundation.org, linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150420125922.35243e90@sluggy>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 04/20/2015 02:59 PM, Clark Williams wrote:
>> > That said, if the lack of a sysfs knob has been causing real problems,
>> > let's make that happen.
> I'll talk to the other RT-ers and get back to you on that. I suspect
> most folks would like it just to not have to reboot while tuning, but
> not sure it's worth the extra code. 

I agree that users do not like to reboot the system while tuning
policy:priority. Thus, be able to adjust it without reboot is a good option.

Daniel
