From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] trace-cmd 2.6.1
Date: Fri, 5 May 2017 19:54:34 -0400
Message-ID: <20170505195434.18a430ea@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>
To: "linux-trace-users@vger.kernel.org"
        <linux-trace-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-trace-users-owner@vger.kernel.org>
Sender: linux-trace-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Announce of trace-cmd 2.6.1

It's been a while since I released any official version of trace-cmd, and
there's been lots of updates (although it took me a while to even push those up
to the repo). Here's a brief list of what's happened since 2.6:

  trace-cmd record:

    --max-graph-depth has been added.

    --ts-offset has been added.

    For more details, see the man pages.

  trace-cmd report:

    -I was added (no events with 'h' set)

    -S was added (no events with 's' set)

    --ts-offset was added

    --tv2tsecs was added

    --tsdiff was added

  trace-cmd list:

    --debug (undocumented) for my use mostly.

Bug fixes:

  Fixed the timestamp format issue (rounding error)

  Output fixes

  Fix build with NO_PTRACE=1

  Make sure plog() gets to console before crashing

  Do not call malloc or realloc and friends from signal handler


Clean ups:

   Lots of removal of malloc_or_die()

Enhancements:

  Use of set_event_pid and event-fork option. When available, use them instead
  of writing in pid filters into the event and function filters. Also means
  ptrace is not needed for tracing children.

  trace-cmd start/record -n will now update set_graph_notrace

  Filtering out trace-cmd recorder threads when filtering is used.

  Add "%" (modulus) processing in print formats.

  '~' is handled within print_flags

  Auto completion for bash.

  New "trace-msg" protocol for listen, added.

  Use of /var/run and /var/lib instead of /usr/local/*

  Some helpers for external users.

  Force "NO_PYTHON=1" if swig is not installed


And there were other cleanups, bug fixes and enhancements. Also kernelshark got
some loving too.

Now, my versioning has been up to now pretty much haphazard in what I've been
doing. I'm finally getting around to fixing that too.

This is the 2.6.1 stable release of 2.6, which is where I'm also going to fork
my 2.7 development from. All new updates for v2.6 will go in the
trace-cmd-stable-v2.6 branch, and will not be released till there's a 2.6.2
ready. The first commit to the master branch on top of that will be a change to
create a 2.7.dev version, which will not be a tag. Only number releases will
be. When 2.7 is released, I will create a trace-cmd-stable-v2.7 which will
start at that commit for bug fixes only. The next commit in master after the
2.7 commit will be a change to make a 2.8.dev, where all new development will
be on top of that. This will make version numbers more meaningful. Only v2.6.1
will be a ".1" release in the master branch after this, as I'm starting the
process at this release.

I will try harder to keep master up to date, with the latest development. But
if you run "trace-cmd --version" and there's a ".dev" attached to it, that
means that your trace-cmd may be unstable. Only the full number releases will
go through full testing. I hope this makes sense.

-- Steve
