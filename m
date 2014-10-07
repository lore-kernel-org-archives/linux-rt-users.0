From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Tue, 7 Oct 2014 03:33:40 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1410070237190.4383@nanos>
References: <542A88A8.7060800@steinhoff.de> <alpine.DEB.2.11.1410010058160.4455@nanos> <542BACF1.3090405@steinhoff.de> <CAA7pwKPcT_YvQx9_nvSXCq3sFB3aCRZ-mGWTk4GOvLn0k7c3_w@mail.gmail.com> <542D0689.8050602@steinhoff.de> <542FD0BE.10508@osadl.org>
 <542FE9B4.3060708@steinhoff.de> <alpine.DEB.2.11.1410042312440.4383@nanos> <54312C88.8060609@steinhoff.de> <alpine.DEB.2.11.1410051453590.4383@nanos> <54329A4B.7080706@steinhoff.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56696 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbaJGBdn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Oct 2014 21:33:43 -0400
In-Reply-To: <54329A4B.7080706@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 6 Oct 2014, Armin Steinhoff wrote:

> Sorry ... I got now time to read your test code and results in detail.
> Your test shows only the absence of failures in your "test" scenario.

Correct. So that proves that the kernel behaviour is correct, right?

Did you try to verify that test case on your system? Maybe you have,
but you did not report back, right?

Did you draw any conclusions from that experiment aside of "absence of
failures in my test scenario"? Maybe you have, but you did not report
back.

> My bug report provided in Bugzilla shows all informations about the facts.

Lemme look at the facts of https://bugzilla.kernel.org/show_bug.cgi?id=85501

Fact #1: 

  "A multithreaded user space application starts some threads with
   different RT priorities. After the first start of one of these RT
   threads, a bunch a other running processes jumping to the highest
   prio of 99!"

This is simply wrong. These processes are reniced to 99, which is the
lowest priority in the system. As I told you before: "man ps"

Fact #4 part 1: https://bugzilla.kernel.org/show_bug.cgi?id=85501#c3

  The output of the command "ps -elf" is incorrect or simply nonsense.

Lets do an experiment

# ps -elf | grep -m 1 acpid
1 S root      1438     1  0  80   0 -  1058 poll_s 18:44 ?        00:00:00 /usr/sbin/acpid

Now we renice all processes which belong to root by 20, i.e. we tell
the scheduler that these are the least favourable processes in the
system.

# renice -n 19 -u root
# ps -elf | grep -m 1 acpid
1 S root      1438     1  0  99  19 -  1058 poll_s 18:44 ?        00:00:00 /usr/sbin/acpid

And 'ps' tells us correctly, that priority changed from 80 to 99 and
nice value changed from 0 to 19. 80 + 19 = 99, right?

Lets switch it back to normal

# renice -n 0 -u root
# ps -elf | grep -m 1 acpid
1 S root      1438     1  0  80   0 -  1058 poll_s 18:44 ?        00:00:00 /usr/sbin/acpid

Surely 'ps' output is nonsense, right?

Fact #4 part 2: https://bugzilla.kernel.org/show_bug.cgi?id=85501#c3

  "ps -e -L -o class,rtprio,pri,nice,cmd" does'nt show priority
  changes of other unrelated processes ... but the values of pri and
  nice are swapped!

# ps -eo tid,comm,cls,pri,nice | grep -m 1 acpid
1438 acpid            TS  19   0

So the scheduling class is TS, prio is 19 and nice is 0

Now we renice all processes which belong to root by 20, i.e. we tell
the scheduler that these are the least favourable processes in the
system.

# renice -n 19 -u root
# ps -eo tid,comm,cls,pri,nice | grep -m 1 acpid
1438 acpid            TS   0  19

And that's what we expected. The scheduling class is still TS, prio is
0 and nice is 19.

Nonsensical as well according to your 'bug report'.

So while I agree that this is not intuitive, it is definitely not a
bug of ps. It's well documented behaviour and for the different ps
modes it is consistent behaviour.

If you feel confused by it, it's not a problem of the RT kernel at
all. If you think this is wrong, feel free to report a bug against
'ps', but don't continue to pester people who are not responsible for
this.

> I could upload my test app to the bug report ... so you get a chance to

Don't bother. I got it from source and you already spammed all list
members with a 400k+ tarball of it.

Now compiling the thing from source and running it, does not show any
of this behaviour.

So to put this to an end I could be bothered to run your version of
it. And funny enough it shows the problem.

The obvious conclusion is, that if the problem only happens with
the particular executable you compiled, it's neither a problem of the
kernel nor a problem of ps, right?

Surprising, isn't it?

Now if you look at your ps outputs you will notice, that only
processes which belong to user root are reniced to 99. If you can be
bothered to redo the above experiments you probably will notice the
same thing.

So the next obvious conclusion is, that this executable which you
provided issues a syscall which does the same thing as 'renice 19 -u
root', right?

So lets first look what renice does.

# strace renice -n 19 - u root

And looking at the output of syscalls there is the relevant one:

setpriority(PRIO_USER, 0, 19)           = 0

So if my not so reality distorted theory holds, we should see
something similar with your executable, right?

# strace ./demo_mn_console

And searching for setprority in the strace output shows:

setpriority(PRIO_USER, 0, 20)           = 0

Not exactly the same, but the nice value is clamped to 19, so the
kernel treats it the same way.

Now what issues that call? Obviously not ps.

As you did not provide any pointer to the source, I have no idea what
kind of bug is there. 

Just for completeness sake, I looked at the public available source
and put a breakpoint on initSystem(). At the point where the
breakpoint was reached, no problem. Single stepping over the next
function showed the problem with your executable, but not with the one
compiled from the pulic source tree.

The public available source calls 

    nice(-20)

at this point, which is definitely not going to call 

   setpriority(PRIO_USER, 0, 20)           = 0

simply because nice(-20) is issuing the syscall with

   setpriority(PRIO_PROCESS, 0, -20)       = 0

according to the strace output of the version I compiled.

Now looking at the disassembly of your executable tells me:

000000000040b954 <initSystem>:
  40b954:       55                      push   %rbp
  40b955:       48 89 e5                mov    %rsp,%rbp
  40b958:       53                      push   %rbx
  40b959:       48 81 ec a8 02 00 00    sub    $0x2a8,%rsp
  40b960:       ba 14 00 00 00          mov    $0x14,%edx
  40b965:       be 00 00 00 00          mov    $0x0,%esi
  40b96a:       bf 02 00 00 00          mov    $0x2,%edi
  40b96f:       e8 2c e2 ff ff          callq  409ba0 <setpriority@plt>

that it is calling setpriority() with the arguments

     which = 2 	   (PRIO_USER)
     who   = 0     (root)
     prio  = 0x14  (20)

And that's exactly what is causing your problem.

While the executable I compiled from the public available source gives
me the following disassembly:

0000000000409f70 <initSystem>:
  409f70:       48 81 ec 38 01 00 00    sub    $0x138,%rsp
  409f77:       bf ec ff ff ff          mov    $0xffffffec,%edi
  409f7c:       e8 8f ea ff ff          callq  408a10 <nice@plt>

So that calls nice() with the argument

     prio = 0xffffffec	  (-20)

Which is what you expect.

So the "facts" of your bug report are correct in the observation that:

   Starting your application is causing unexpected behaviour and the
   output of 'ps -elf' proves that issue.

And that's where the facts end.

> replicate these problems and get out of your "realty distortion".

Sure, my reality distortion is:

 - That I knew as everybody else on this thread that the problem is
   inside your application.

   It was obvious from your own observation:

   >> If the app "demo_mn_console" has started its first RT thread,  a lot
   >> of other processes/threads are jumping to the highest RT priority
   >> 99!!

 - That I did not follow your reasoning that:

   >> we have a problem with the RT kernel ? Or is simply the ps
   >> utility broken ?

 - That I asked you politely to follow the bug reporting procedures,
   which you refused.

   If you look at the above disassembly sections, you should be aware
   why I can prove that.

 - That Carsten gave you a detailed argument chain, which pointed
   obviously to the application itself. But you completely ignored it:

   "> 7. Your first suspicion is that we may have a problem with the RT kernel.
    > 8. And your second suspicion is that the ps utility is broken.
    > Doesn't come another suspicion to mind?

    Why should I have one? The same code works correctly under then
    non-RT version of the kernel ... at least from the Linux point of
    view."

 - That I told you how to interpret the PRI field of the ps -elf
   output and you simply refused to even think about it. 

   Instead of that you file bug reports against 'ps' on the kernel
   bugzilla. Can you see why the kernel bugzilla is the wrong place to
   file bug reports against 'ps' ?

   And then you told me clearly:

   "Sorry for not bothering about the confusing handling of priorities
    within LINUX ..."

   So despite the fact, that I asked you to make your self familiar
   with 'ps', you insist on 'ps' being broken and file a bug report
   against the RT kernel component?

 - That I know how 'ps' works

   I told you to study 'man ps'. That should have been enough hint to
   decode the issue.

 - That I knew that neither the v3.4.0-rc7-rt7 nor the v3.4.121-rt97
   kernel version was responsible for your problems?

   Sure. That must be a heavy reality distortion field which caused me
   to believe that I can figure that out w/o looking at your claims.

 - That I figured out without having access to the source code of your
   executable, that you are either running a modified version of the
   open powerlink code or your build setup has a massive failure.

   I don't care either way, but you might understand that neither of
   these problems are relevant for this particular mailinglist.
 
> Asking question for a confusing failure situation has nothing to with
> "abusing the community!

Asking about it definitely not, but refusing to follow any advise and
refusing to follow the hints people give you defintely counts for it.

> Yes, I got 3 good hints ... no statement about the arrogant "hint" from you.
> It's quite normal to "have theories about a failures" as long as I
> verify these in order to find the real problem.

Sure, you can have your own view of "having theories about failures",
but a community mailing list does not necessarily have to share that
view. We care about facts and not about random theories caused by
whatever failure modes.

> Are you trying to kidding me with this statement: "Why should we be
> bothered to solve your business problems,"
> 
> Do you really believe I have a business problem ?  There is simpy
> absolute no business with PREEMPT_RT!  I do only some strategic work
> for a potential usage of PREEMP_RT ... hope this solves your
> problem.

I have no problem with that. Just your website offerings tell a
different story.

 http://bit.ly/1pIsqca

The topmost link says:

    Steinhoff Automations & Feldbus-Systeme
    www.steinhoff.de/
    
    FIELDBUS PAGE for OPEN CONTROL system DACHS from STEINHOFF,
    ... all DACHS products are offered for QNX, and Standard &
    PREEMPT_RT Linux !

If I'm not completely mistaken, that's your website.

So you are offering commercial solutions based on PREEMPT_RT. Whether
that offerings generate a business for you or not is completely
irrelevant. Whether you are doing only strategic work for your already
existing offerings or not is equally irrelevant. Thats merily your
problem.

I really do not care about your business at all. What I care about is
your abusive behaviour that a community mailing list has to bear
with.

> I'm working since 25 years wit QNX and other classical real-time
> operation systems. I did also operating system development for many
> years ... but before the first LINUX version was released. So be
> careful to tell me something about "incompetence" ...

I'm really not in a position to judge your competence. I merely care
about facts.

- Fact is that you ignored any advise and any hints given to you and
  insist that the community has to bear your 'quite normal theories'.

- Fact is that you seek community advise, but then you state:

  "Sorry for not bothering about the confusing handling of priorities
   within LINUX ..."

   So we are supposed to help you while you refuse to understand how it
   works?

- Fact is that you said:

  >> Hint #2: linux/REPORTING-BUGS
  > OK  ... still TODO 

  AFAICT this is still on your todo list, right?

- Fact is that you said in response to Carsten:

  Carsten: "5. At a given time, you start your application that apparently modifies
 	    task priorities *in some way*."

  You:     "Not in some way ... the developers of the openPOWERLINK stack are using
 	    plain POSIX calls."

  Nothing wrong with that, just I cannot figure out why the usage of
  plain posix calls has anything to do with the wrong usage of posix
  calls? And as I showed above this is a case of plain wrong usage of
  posix calls.

- Fact is that the executable you provided issues a syscall which
  causes a siutation which you claimed to be either a problem of the
  kernel or a problem of the ps utility.

- Fact is that I decoded the issue without having access to the source
  code within a few minutes.

- Fact is that you failed to decode the issue despite of having access
  to the source code of the application.

- Fact is that the community provided source code does not have this
  issue.

- Fact is that is was obvious that "problem starts after doing X" has
  to be related with X. 

  You have have been told so, but you deliberately decided to to
  ignore that advise.

- Fact is that you claim publically that I'm suffering of reality
  distortion.

  See above and then make further claims at your leisure.

Thanks,

	tglx
