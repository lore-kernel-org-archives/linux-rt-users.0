From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 29/33] tracing: Add inter-event hist trigger
 Documentation
Date: Tue, 17 Oct 2017 21:36:57 -0400
Message-ID: <20171017213657.4b0b78f6@gandalf.local.home>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
        <4c06d6648839b387c4df09752329a09816e09f31.1506105131.git.tom.zanussi@linux.intel.com>
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
In-Reply-To: <4c06d6648839b387c4df09752329a09816e09f31.1506105131.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 22 Sep 2017 15:00:09 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Add background and details on inter-event hist triggers, including
> hist variables, synthetic events, and actions.

One more thing. Make this a separate document. Don't add it to the
events.txt. Have a histogram.txt or something and just have events.txt
reference that document.

Thanks!

-- Steve

> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> Signed-off-by: Baohong Liu <baohong.liu@intel.com>
> ---
>
