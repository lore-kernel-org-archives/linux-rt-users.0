From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc: Make it possible to safely select
	CONFIG_FRAME_POINTER
Date: Thu, 05 Feb 2009 12:15:31 +1100
Message-ID: <1233796531.4612.35.camel__41676.9289681271$1233796675$gmane$org@pasglop>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150838.GB30027@oksana.dev.rtsoft.ru>
	<1233793889.4612.33.camel@pasglop>
	<1233794154.16878.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <srostedt@redhat.com>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <1233794154.16878.20.camel@localhost.localdomain>
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

On Wed, 2009-02-04 at 19:35 -0500, Steven Rostedt wrote:
> On Thu, 2009-02-05 at 11:31 +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2009-02-04 at 18:08 +0300, Anton Vorontsov wrote:
> > > Remove -fno-omit-frame-pointer flag from CFLAGS.
> > > Remove -fno-omit-frame-pointer workarounds.
> > 
> > But what about -pg -requires -fno-omit-frame-pointer ?
> 
> I don't think it requires -fno-omit-frame-pointer. It is just
> incompatible with -fomit-frame-pointer.

>From a quick test, you seem to be right.

Now the question of course is whether -pg will internally trigger
the bug for which we need the workaround tho...

Ben.
