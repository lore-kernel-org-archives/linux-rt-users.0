From: Subrata Modak <subrata-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: 2.6.25.4-rt4
Date: Wed, 25 Jun 2008 18:59:35 +0530
Message-ID: <1214400575.10818.34.camel@subratamodak.linux.ibm.com>
References: <1212076754.24785.18.camel@localhost.localdomain>
	<1212324634.4678.5.camel@subratamodak.linux.ibm.com>
	<Pine.LNX.4.58.0806021332150.10366@gandalf.stny.rr.com>
	<1212504482.4715.29.camel@subratamodak.linux.ibm.com>
Reply-To: subrata-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: ltp-list <ltp-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>,
	linux-rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Return-path: <ltp-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1212504482.4715.29.camel-NRFfyExJdYpgXGGE5LP+UZlqa2bBAFbm0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ltp-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ltp-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ltp-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2008-06-03 at 20:18 +0530, Subrata Modak wrote:
> On Mon, 2008-06-02 at 13:42 -0400, Steven Rostedt wrote:
> > On Sun, 1 Jun 2008, Subrata Modak wrote:
> > 
> > >
> > > Dear Steve,
> > >
> > > I am hopeful that you might know that we have started to maintain RT
> > > linux test cases inside Linux Test Project (http://ltp.sourceforge.net/)
> > > from Dec 2007 onwards. With initial integration from IBM, these set of
> > > test cases has been enriched so far from IBM, BULL and PENGUTRONICS.
> > > Would you like to review them at:
> > > http://ltp.cvs.sourceforge.net/ltp/ltp/testcases/realtime/.
> > >
> > > I am hopeful that you can give me an idea of how these test cases are in
> > > sync with your RT tree releases, and also find out the gaps where more
> > > testing and hence test cases needs to be done/added.
> > >
> > 
> > Hi,
> > 
> > Thanks, they should all stay in sync since they are userland tools and we
> > try to keep the user API the same. But, with that said, the ftrace code is
> > still under development, and some of the tests do interact with it. I'll
> > try to remember to send patches to keep them updated.

Hi Steven,

Would you like to send some patches now ?

Regards--
Subrata

> 
> Thanks Steve for your forthcoming help and contribution. I will also
> meanwhile keep you in loop for all the RT tests updates if any in LTP.
> 
> Regards--
> Subrata
> 
> > 
> > Thanks,
> > 
> > -- Steve
> > 
> 
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/ltp-list


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
