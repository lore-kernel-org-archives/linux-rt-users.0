From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC][PATCH 07/10] tracing: Have zero size length in filter
 logic be full string
Date: Mon, 14 May 2018 11:23:09 +0900
Message-ID: <20180514022309.GA9220@sejong>
References: <20180511194927.190877137@goodmis.org>
 <20180511195341.034688188@goodmis.org>
 <CAKQ1sVPS_rKYUVRRAU-zHKZqCNBKamBoHdHyhXOV+Ckifm1Jbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joelaf@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Yann Ylavic <ylavic.dev@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKQ1sVPS_rKYUVRRAU-zHKZqCNBKamBoHdHyhXOV+Ckifm1Jbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

On Sat, May 12, 2018 at 08:32:18PM +0200, Yann Ylavic wrote:
> On Fri, May 11, 2018 at 9:49 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> []
> >
> >  static int regex_match_front(char *str, struct regex *r, int len)
> >  {
> > -       if (len < r->len)
> > +       if (len && len < r->len)
> >                 return 0;
> >
> > -       if (strncmp(str, r->pattern, r->len) == 0)
> > -               return 1;
> > -       return 0;
> > +       return strncmp(str, r->pattern, len) == 0;
> 
> strncmp(..., r->len) still?

Yep, I think so.  Otherwise it'll always return true when len is 0.

Thanks,
Namhyung
