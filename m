Return-Path: gbtju85@gmail.com
MIME-Version: 1.0
In-Reply-To: <20111205103609.1ad7b373@redhat.com>
References: <CAEQjb-TXX8bUULQVWOAQZjAxj7DVrA2ehs039qEH5zSe2BSfLA@mail.gmail.com>
	<1323096173.30977.77.camel@frodo>
	<20111205085950.751ffea3@redhat.com>
	<CAEQjb-S6Ezy=d4k6p93uUcj+Osovc0kE6POmbYfjyS=dAARc8w@mail.gmail.com>
	<20111205103609.1ad7b373@redhat.com>
Date: Mon, 5 Dec 2011 21:05:32 -0500
Message-ID: <CAEQjb-TVaBZHbRBodLsBBPjJAMCd1xw9c_iLA-wX4ZmhRuacgQ@mail.gmail.com>
Subject: Re: Where can I get the latest cyclictest or the version 0.72
From: Bei Guan <gbtju85@gmail.com>
Content-Type: multipart/alternative; boundary=f46d04462eb4c0cbf704b362deb3
To: Clark Williams <williams@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-rt-users <linux-rt-users@vger.kernel.org>
List-ID: <linux-rt-users.vger.kernel.org>

--f46d04462eb4c0cbf704b362deb3
Content-Type: text/plain; charset=ISO-8859-1

2011/12/5 Clark Williams <williams@redhat.com>

> Bei,
>
> That's a git tree. You'll need to compile the images from there.
>
> What distro are you using? Debian delivers rt-tests as a .deb, so you
> could just apt-get it from there. I don't think Fedora delivers
> rt-tests as an RPM.
>
I have two distros, Fedora and Ubuntu. Under the Fedora, I just use "make
install" and it seems to work well. Now I can use the command cyclictest in
Fedora.

But, under the Ubuntu, you mean I can use apt-get. Is the following right?
apt-get install github.com/clrkwllms/rt-tests.git
 (But it doesn't work. Please correct me.)


Another question, how to get the histogram graphic using the cyclictest. I
use the following command but I cannot get it.

[root@localhost ~]# cyclictest -h -s -p 80 -n -i 10000 -l 1000
WARNING: High resolution timers not available
policy: fifo: loadavg: 0.13 0.10 0.09 4/229 5283

T: 0 ( 5283) P:80 I:10000 C:   1000 Min:  14420 Act:14496 Avg:14712 Max:
24567
WARNING: unable to open events/enable


Thanks,
Bei Guan





> Clark
>
> On Mon, 5 Dec 2011 23:30:44 +0800
> Bei Guan <gbtju85@gmail.com> wrote:
>
> > Thank all of you very much.
> >
> > Hi Clark,
> >
> > How to install this new version? Could you give me
> > some instructions? Thanks.
> >
> >
> > Best Wishes,
> > Bei Guan
> >
> >
> >
> >
> > 2011/12/5 Clark Williams <williams@redhat.com>
> >
> > > On Mon, 05 Dec 2011 09:42:53 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > > On Mon, 2011-12-05 at 21:32 +0800, Bei Guan wrote:
> > > > > Hi,
> > > > >
> > > > >
> > > > > I am very sorry to disturb you, but I find the mails I delivered
> > > > > to linux-rt-users mailing list are all failed. So maybe you can
> help
> > > > > me out of my question or forward my question to a correct man.
> Thank
> > > > > you very much.
> > > > >
> > > > >
> > > > > Where can I get the latest cyclictest or the version 0.72? I try
> the
> > > > > following links, but it seems not available now.
> > > > > http://www.kernel.org/pub/linux//kernel/people/clrkwllms/rt-tests/
> > > > >
> > > >
> > > >
> > > > Clark,
> > > >
> > > > Can you answer this.
> > > >
> > > > Thanks,
> > > >
> > > > -- Steve
> > > >
> > > >
> > > >
> > >
> > > Currently (until I get my kernel.org account set back up) I'm keeping
> > > it on github:
> > >
> > >        git://github.com/clrkwllms/rt-tests.git
> > >
> > > No tarballs available, just the git tree.
> > >
> > > Hopefully I'll get my k.o. account back up this week and will be back
> > > to the old spot.
> > >
> > > Clark
> > >
> >
> >
> >
> > --
> > Best Regards,
> > Bei Guan
>



-- 
Best Regards,
Bei Guan

--f46d04462eb4c0cbf704b362deb3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">2011/12/5 Clark Williams <span dir=3D"ltr">&=
lt;<a href=3D"mailto:williams@redhat.com">williams@redhat.com</a>&gt;</span=
><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Bei,<br>
<br>
That&#39;s a git tree. You&#39;ll need to compile the images from there.<br=
>
<br>
What distro are you using? Debian delivers rt-tests as a .deb, so you<br>
could just apt-get it from there. I don&#39;t think Fedora delivers<br>
rt-tests as an RPM.<br></blockquote><div>I have two distros, Fedora and Ubu=
ntu. Under the Fedora, I just use &quot;make install&quot; and it seems to =
work well. Now I can use the command cyclictest in Fedora.<br><br>But, unde=
r the Ubuntu, you mean I can use apt-get. Is the following right?<br>
apt-get install <a href=3D"http://github.com/clrkwllms/rt-tests.git">github=
.com/clrkwllms/rt-tests.git</a><br>=A0(But it doesn&#39;t work. Please corr=
ect me.)<br><br><br>Another question, how to get the histogram graphic usin=
g the cyclictest. I use the following command but I cannot get it.<br>
<br>[root@localhost ~]# cyclictest -h -s -p 80 -n -i 10000 -l 1000<br>WARNI=
NG: High resolution timers not available<br>policy: fifo: loadavg: 0.13 0.1=
0 0.09 4/229 5283=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br><br>T: 0 ( 5283) P:80 I:10=
000 C:=A0=A0 1000 Min:=A0 14420 Act:14496 Avg:14712 Max:=A0=A0 24567<br>
WARNING: unable to open events/enable<br><br><br>Thanks,<br>Bei Guan<br><br=
><br><br><br></div><blockquote class=3D"gmail_quote" style=3D"border-left: =
1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;=
">

<font color=3D"#888888"><br>
Clark<br>
</font><div><div></div><div class=3D"h5"><br>
On Mon, 5 Dec 2011 23:30:44 +0800<br>
Bei Guan &lt;<a href=3D"mailto:gbtju85@gmail.com">gbtju85@gmail.com</a>&gt;=
 wrote:<br>
<br>
&gt; Thank all of you very much.<br>
&gt;<br>
&gt; Hi Clark,<br>
&gt;<br>
&gt; How to install this new version? Could you give me<br>
&gt; some instructions? Thanks.<br>
&gt;<br>
&gt;<br>
&gt; Best Wishes,<br>
&gt; Bei Guan<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; 2011/12/5 Clark Williams &lt;<a href=3D"mailto:williams@redhat.com">wi=
lliams@redhat.com</a>&gt;<br>
&gt;<br>
&gt; &gt; On Mon, 05 Dec 2011 09:42:53 -0500<br>
&gt; &gt; Steven Rostedt &lt;<a href=3D"mailto:rostedt@goodmis.org">rostedt=
@goodmis.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; On Mon, 2011-12-05 at 21:32 +0800, Bei Guan wrote:<br>
&gt; &gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I am very sorry to disturb you, but I find the mails I =
delivered<br>
&gt; &gt; &gt; &gt; to linux-rt-users mailing list are all failed. So maybe=
 you can help<br>
&gt; &gt; &gt; &gt; me out of my question or forward my question to a corre=
ct man. Thank<br>
&gt; &gt; &gt; &gt; you very much.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Where can I get the latest cyclictest or the version 0.=
72? I try the<br>
&gt; &gt; &gt; &gt; following links, but it seems not available now.<br>
&gt; &gt; &gt; &gt; <a href=3D"http://www.kernel.org/pub/linux//kernel/peop=
le/clrkwllms/rt-tests/" target=3D"_blank">http://www.kernel.org/pub/linux//=
kernel/people/clrkwllms/rt-tests/</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Clark,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Can you answer this.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -- Steve<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Currently (until I get my <a href=3D"http://kernel.org" target=3D=
"_blank">kernel.org</a> account set back up) I&#39;m keeping<br>
&gt; &gt; it on github:<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0git://<a href=3D"http://github.com/clrkwllms/rt-te=
sts.git" target=3D"_blank">github.com/clrkwllms/rt-tests.git</a><br>
&gt; &gt;<br>
&gt; &gt; No tarballs available, just the git tree.<br>
&gt; &gt;<br>
&gt; &gt; Hopefully I&#39;ll get my k.o. account back up this week and will=
 be back<br>
&gt; &gt; to the old spot.<br>
&gt; &gt;<br>
&gt; &gt; Clark<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Best Regards,<br>
&gt; Bei Guan<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Best Regard=
s,<div>Bei Guan</div><br>

--f46d04462eb4c0cbf704b362deb3--
