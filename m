From: Yann Ylavic <ylavic.dev@gmail.com>
Subject: Re: [RFC][PATCH 07/10] tracing: Have zero size length in filter logic
 be full string
Date: Sat, 12 May 2018 20:32:18 +0200
Message-ID: <CAKQ1sVPS_rKYUVRRAU-zHKZqCNBKamBoHdHyhXOV+Ckifm1Jbw@mail.gmail.com>
References: <20180511194927.190877137@goodmis.org> <20180511195341.034688188@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joelaf@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511195341.034688188@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, May 11, 2018 at 9:49 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
[]
>
>  static int regex_match_front(char *str, struct regex *r, int len)
>  {
> -       if (len < r->len)
> +       if (len && len < r->len)
>                 return 0;
>
> -       if (strncmp(str, r->pattern, r->len) == 0)
> -               return 1;
> -       return 0;
> +       return strncmp(str, r->pattern, len) == 0;

strncmp(..., r->len) still?

>  }

Regards,
Yann.
