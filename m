From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
Date: Sun, 15 Feb 2009 11:19:56 +1100
Message-ID: <1234657196.26036.86.camel__23148.505020845$1234657340$gmane$org@pasglop>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150835.GA30027@oksana.dev.rtsoft.ru>
	<20090204212612.GN22608@elte.hu>
	<20090214195702.GB1241@uranus.ravnborg.org>
	<20090214220326.GA5200@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Sam Ravnborg <sam@ravnborg.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20090214220326.GA5200@elte.hu>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2009-02-14 at 23:03 +0100, Ingo Molnar wrote:
> 
> So the question is: even with FRAME_POINTERS disabled on PPC, is 
> __builtin_return_address(1)/(2) reliable, and is save_stack_trace() fast? (i.e.
> can it walk down the stack frame efficiently, or does it have to scan the full
> kernel stack) I.e. does PPC have all the material advantages of frame pointers?

Yes, we do. We effectively have frame pointers in fact, they may only be
omitted in leaf functions but then gcc __builtin_return_address() knows
how to handle that afaik.

Cheers,
Ben.
