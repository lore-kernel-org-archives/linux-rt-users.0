From: Subrata Modak <subrata-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: realtime run shellscripts suite - anyone using it?
Date: Thu, 15 May 2008 12:18:22 +0530
Message-ID: <1210834102.4738.1.camel@subratamodak.linux.ibm.com>
References: <4829A2B7.2010200@bull.net>
	<1210750236.4747.6.camel@subratamodak.linux.ibm.com>
	<200805151131.29082.sripathik@in.ibm.com>
Reply-To: subrata-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: ltp-list <ltp-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	tinytim <tinytim-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>,
	linux-rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	dino <dino-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>,
	Sebastien Dugue <sebastien.dugue-6ktuUTfB/bM@public.gmane.org>,
	Jean-Pierre Dion <jean-pierre.dion-6ktuUTfB/bM@public.gmane.org>
To: Sripathi Kodi <sripathik-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org>,
	Gilles Carry <Gilles.Carry-6ktuUTfB/bM@public.gmane.org>,
	dvhltc <dvhltc-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Return-path: <ltp-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200805151131.29082.sripathik-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org>
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

On Thu, 2008-05-15 at 11:31 +0530, Sripathi Kodi wrote:
> On Wednesday 14 May 2008 13:00, Subrata Modak wrote:
> > Forwarding Gilles query to other RT developers.
> >
> > Regards--
> > Subrata
> >
> > On Tue, 2008-05-13 at 16:16 +0200, Gilles Carry wrote:
> > > Hello,
> > >
> > > I am investigating on how to run profiled tests for realtime
> > > systems. I would like to do something integrated in the existing
> > > system.
> > >
> > > After having roughly analyzed the existing scripts:
> > > - run.sh looks for run_auto.sh files in tests dirs and run them
> > > - run_auto.sh runs scripts/run_c_files.sh
> > >
> > > It turns out that the value added of these scripts is merely to set
> > > some env vars and log stdout/err of tests. (am I missing
> > > something?)
> > >
> > > Also, this cascade of scripts must deal with args which are
> > > defined, analyzed and passed again to subsequent scripts. Tere are
> > > also other tricks that make the whole thing heavy and uneasy.
> > >
> > > I want to write a simple script that runs command lines read from a
> > > test profile choosed by the user (having each different arguments -
> > > ie. pass criteria)
> > >
> > > Does anyone minds my simplifying the existing script suite?
> 
> Hi Gilles, Subrata,
> 
> In our project, we use the these scripts to run all or a selected bunch 
> of tests under realtime directory. Please have a look at the output 
> of "run.sh -h" under testcases/realtime. We also use the log files 
> extensively. As far as existing  functionality is provided, we have no 
> problems with doing improvements to the scripts.

Hi Gilles,

I think you can go ahead with your improvements to these scripts after
getting feedback from Sripathi and Darren.

Regards--
Subrata

> 
> Thanks,
> Sripathi.
> 
> 
> > >
> > >
> > > Gilles.
> > >
> > > -------------------------------------------------------------------
> > >------ This SF.net email is sponsored by: Microsoft
> > > Defy all challenges. Microsoft(R) Visual Studio 2008.
> > > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > > _______________________________________________
> > > Ltp-list mailing list
> > > Ltp-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/ltp-list
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-rt-users" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
