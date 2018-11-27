From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v7 05/16] tracing: Generalize hist trigger onmax and
 save action
Date: Tue, 27 Nov 2018 16:48:56 -0600
Message-ID: <1543358936.4223.3.camel@kernel.org>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
         <9baa2b4a9b708791b39f176e3b63c207163d8c3b.1542221863.git.tom.zanussi@linux.intel.com>
         <20181123070105.GA3838@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181123070105.GA3838@sejong>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Fri, 2018-11-23 at 16:01 +0900, Namhyung Kim wrote:
> On Wed, Nov 14, 2018 at 02:18:02PM -0600, Tom Zanussi wrote:
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > 

[snip]

> > -
> > -	update_max_vars(hist_data, elt, rbe, rec);
> > +	if (update_track_val(hist_data, elt, data, var_ref_vals))
> > +		update_save_vars(hist_data, elt, rbe, rec);
> 
> ... and then it should look like:
> 
> 	if (check_track_val()) {
> 		save_track_val();
> 		update_save_vars();
> 	}
> 
> I also think update_save_vars() also needs to be renamed something
> like save_track_vars() or save_trace_data().
> 

Yes, this is much nicer - I've made these changes and more for v8. 
Thanks for the input.

Tom
