From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 36/40] tracing: Remove lookups from tracing_map
 hitcount
Date: Tue, 12 Sep 2017 09:16:11 -0500
Message-ID: <1505225771.1331.3.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <4c3ada8f9d958a5a926bbfa812c816bf8e73764b.1504642143.git.tom.zanussi@linux.intel.com>
         <20170912111611.a629bdf12ccaa001c3c518ff@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912111611.a629bdf12ccaa001c3c518ff@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Masami,

On Tue, 2017-09-12 at 11:16 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Tue,  5 Sep 2017 16:57:48 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Lookups inflate the hitcount, making it essentially useless.  Only
> > inserts and updates should really affect the hitcount anyway, so
> > explicitly filter lookups out.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  kernel/trace/tracing_map.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> > index a4e5a56..f8e2338 100644
> > --- a/kernel/trace/tracing_map.c
> > +++ b/kernel/trace/tracing_map.c
> > @@ -538,7 +538,8 @@ static inline bool keys_match(void *key, void *test_key, unsigned key_size)
> >  		if (test_key && test_key == key_hash) {
> >  			if (entry->val &&
> >  			    keys_match(key, entry->val->key, map->key_size)) {
> > -				atomic64_inc(&map->hits);
> > +				if (!lookup_only)
> > +					atomic64_inc(&map->hits);
> 
> Is this a kind of bugfix for current code?
> If so, such patch can be posted in separate series.
> 

Yeah, that sounds like a good idea - will separate this out along with
another one or two in the same boat..

Thanks,

Tom
