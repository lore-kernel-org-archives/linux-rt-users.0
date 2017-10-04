From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 03/33] ring-buffer: Add interface for setting
 absolute time stamps
Date: Wed, 4 Oct 2017 13:14:30 -0400
Message-ID: <20171004131430.6e459b0a@gandalf.local.home>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
        <df519705509bf3ed5fccf2a88dec2b216d19f088.1506105131.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <df519705509bf3ed5fccf2a88dec2b216d19f088.1506105131.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 22 Sep 2017 14:59:43 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> +	/*
> +	 * New timestamps may not be consistent with the previous setting.
> +	 * Reset the buffer so that it doesn't have incomparable timestamps.

I would like to make the ring buffer robust enough to handle both. Can
this be done?

-- Steve

> +	 */
> +	tracing_reset_online_cpus(&tr->trace_buffer);
> +
