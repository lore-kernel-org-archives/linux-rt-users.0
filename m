Return-Path: gbtju85@gmail.com
MIME-Version: 1.0
In-Reply-To: <20111206100813.5aa8b287@redhat.com>
References: <CAEQjb-TXX8bUULQVWOAQZjAxj7DVrA2ehs039qEH5zSe2BSfLA@mail.gmail.com>
	<1323096173.30977.77.camel@frodo>
	<20111205085950.751ffea3@redhat.com>
	<CAEQjb-S6Ezy=d4k6p93uUcj+Osovc0kE6POmbYfjyS=dAARc8w@mail.gmail.com>
	<20111205103609.1ad7b373@redhat.com>
	<CAEQjb-TVaBZHbRBodLsBBPjJAMCd1xw9c_iLA-wX4ZmhRuacgQ@mail.gmail.com>
	<20111206100813.5aa8b287@redhat.com>
Date: Wed, 7 Dec 2011 09:24:18 +0800
Message-ID: <CAEQjb-QmXeAeHVxVZV0M_VzEAbFw3zCnr9Uh0hnggLGUJidHOQ@mail.gmail.com>
Subject: Re: Where can I get the latest cyclictest or the version 0.72
From: Bei Guan <gbtju85@gmail.com>
Content-Type: multipart/alternative; boundary=0016e6d7edfc25f77604b3766991
To: Clark Williams <williams@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-rt-users <linux-rt-users@vger.kernel.org>
List-ID: <linux-rt-users.vger.kernel.org>

--0016e6d7edfc25f77604b3766991
Content-Type: text/plain; charset=ISO-8859-1

OK. It works well in my two distros now. Thank you all very much:)


Best Wishes,
Bei Guan


2011/12/7 Clark Williams <williams@redhat.com>

> On Mon, 5 Dec 2011 21:05:32 -0500
> Bei Guan <gbtju85@gmail.com> wrote:
>
> > 2011/12/5 Clark Williams <williams@redhat.com>
> >
> > > Bei,
> > >
> > > That's a git tree. You'll need to compile the images from there.
> > >
> > > What distro are you using? Debian delivers rt-tests as a .deb, so you
> > > could just apt-get it from there. I don't think Fedora delivers
> > > rt-tests as an RPM.
> > >
> > I have two distros, Fedora and Ubuntu. Under the Fedora, I just use "make
> > install" and it seems to work well. Now I can use the command cyclictest
> in
> > Fedora.
> >
> > But, under the Ubuntu, you mean I can use apt-get. Is the following
> right?
> > apt-get install github.com/clrkwllms/rt-tests.git
> >  (But it doesn't work. Please correct me.)
>
> No you don't need to specify the git repository; there should be a
> package already set up in the stable debian: apt-get install rt-tests
>
> >
> >
> > Another question, how to get the histogram graphic using the cyclictest.
> I
> > use the following command but I cannot get it.
> >
> > [root@localhost ~]# cyclictest -h -s -p 80 -n -i 10000 -l 1000
> > WARNING: High resolution timers not available
> > policy: fifo: loadavg: 0.13 0.10 0.09 4/229 5283
> >
> > T: 0 ( 5283) P:80 I:10000 C:   1000 Min:  14420 Act:14496 Avg:14712 Max:
> > 24567
> > WARNING: unable to open events/enable
> >
>
> The histogram option (-h) takes an argument, which is the max value
> to record in microseconds. So, -h100 would generate a 100 element
> histogram (1 microsecond per line). Since it doesn't look like you're
> running on an RT kernel (no hrtimers available), you'll have a wide
> variance in response times, so you'll need a big histogram range to
> catch everything.
>
> Try this:
>
> # cyclictest -t -p80 -m -i 10000 -l 1000 -h 10000
>
> Then be ready for 10000 lines of output when you control-C out of
> cyclictest.
>
> Clark
>
>
>

--0016e6d7edfc25f77604b3766991
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

OK. It works well in my two distros now. Thank you all very much:)<div><br>=
</div><div><br>Best Wishes,</div><div>Bei Guan</div><div><br><div><br><div =
class=3D"gmail_quote">2011/12/7 Clark Williams <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:williams@redhat.com">williams@redhat.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Mon, 5 Dec 2011 21:05:=
32 -0500<br>
Bei Guan &lt;<a href=3D"mailto:gbtju85@gmail.com">gbtju85@gmail.com</a>&gt;=
 wrote:<br>
<br>
&gt; 2011/12/5 Clark Williams &lt;<a href=3D"mailto:williams@redhat.com">wi=
lliams@redhat.com</a>&gt;<br>
&gt;<br>
&gt; &gt; Bei,<br>
&gt; &gt;<br>
&gt; &gt; That&#39;s a git tree. You&#39;ll need to compile the images from=
 there.<br>
&gt; &gt;<br>
&gt; &gt; What distro are you using? Debian delivers rt-tests as a .deb, so=
 you<br>
&gt; &gt; could just apt-get it from there. I don&#39;t think Fedora delive=
rs<br>
&gt; &gt; rt-tests as an RPM.<br>
&gt; &gt;<br>
&gt; I have two distros, Fedora and Ubuntu. Under the Fedora, I just use &q=
uot;make<br>
&gt; install&quot; and it seems to work well. Now I can use the command cyc=
lictest in<br>
&gt; Fedora.<br>
&gt;<br>
&gt; But, under the Ubuntu, you mean I can use apt-get. Is the following ri=
ght?<br>
&gt; apt-get install <a href=3D"http://github.com/clrkwllms/rt-tests.git" t=
arget=3D"_blank">github.com/clrkwllms/rt-tests.git</a><br>
&gt; =A0(But it doesn&#39;t work. Please correct me.)<br>
<br>
</div>No you don&#39;t need to specify the git repository; there should be =
a<br>
package already set up in the stable debian: apt-get install rt-tests<br>
<div class=3D"im"><br>
&gt;<br>
&gt;<br>
&gt; Another question, how to get the histogram graphic using the cyclictes=
t. I<br>
&gt; use the following command but I cannot get it.<br>
&gt;<br>
&gt; [root@localhost ~]# cyclictest -h -s -p 80 -n -i 10000 -l 1000<br>
&gt; WARNING: High resolution timers not available<br>
&gt; policy: fifo: loadavg: 0.13 0.10 0.09 4/229 5283<br>
&gt;<br>
&gt; T: 0 ( 5283) P:80 I:10000 C: =A0 1000 Min: =A014420 Act:14496 Avg:1471=
2 Max:<br>
&gt; 24567<br>
&gt; WARNING: unable to open events/enable<br>
&gt;<br>
<br>
</div>The histogram option (-h) takes an argument, which is the max value<b=
r>
to record in microseconds. So, -h100 would generate a 100 element<br>
histogram (1 microsecond per line). Since it doesn&#39;t look like you&#39;=
re<br>
running on an RT kernel (no hrtimers available), you&#39;ll have a wide<br>
variance in response times, so you&#39;ll need a big histogram range to<br>
catch everything.<br>
<br>
Try this:<br>
<br>
# cyclictest -t -p80 -m -i 10000 -l 1000 -h 10000<br>
<br>
Then be ready for 10000 lines of output when you control-C out of<br>
cyclictest.<br>
<font color=3D"#888888"><br>
Clark<br>
<br>
<br>
</font></blockquote></div><br><br>
</div></div>

--0016e6d7edfc25f77604b3766991--
