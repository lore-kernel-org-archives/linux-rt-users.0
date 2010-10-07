From: Hemanth Kumar <hemwire@yahoo.co.in>
Subject: Re: Kernel start code
Date: Thu, 7 Oct 2010 10:09:56 +0530 (IST)
Message-ID: <757045.36232.qm@web94713.mail.in2.yahoo.com>
References: <AANLkTinGu9MU-_ZRTr3Y5Om=GeG4pkNUwtcD6=iaO_M+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2108819066-1286426396=:36232"
Cc: Kernel-newbies <kernelnewbies@nl.linux.org>,
  Linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>,
  Pavan Kandepet <pavankp@gmail.com>
Return-path: <kernelnewbies-bounce@nl.linux.org>
In-Reply-To: <AANLkTinGu9MU-_ZRTr3Y5Om=GeG4pkNUwtcD6=iaO_M+@mail.gmail.com>
Sender: kernelnewbies-bounce@nl.linux.org
Errors-to: kernelnewbies-bounce@nl.linux.org
List-help: <mailto:ecartis@nl.linux.org?Subject=help>
List-unsubscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=unsubscribe>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=subscribe>
List-owner: <mailto:ecartis-owner@nl.linux.org>
List-post: <mailto:kernelnewbies@nl.linux.org>
List-archive: <http://mail.nl.linux.org/kernelnewbies/>
List-Id: linux-rt-users.vger.kernel.org

--0-2108819066-1286426396=:36232
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi

=A0=A0=A0=A0=A0 This may help you pretty old,
http://tldp.org/HOWTO/Linux-i386-Boot-Code-HOWTO/




--- On Thu, 7/10/10, Pavan Kandepet <pavankp@gmail.com> wrote:

From: Pavan Kandepet <pavankp@gmail.com>
Subject: Re: Kernel start code
To: "Sri Ram Vemulpali" <sri.ram.gmu06@gmail.com>
Cc: "Kernel-newbies" <kernelnewbies@nl.linux.org>, "Linux-rt-users" <linux-=
rt-users@vger.kernel.org>
Date: Thursday, 7 October, 2010, 4:49 AM

Embedded Linux primer has a good introduction to
kernel bootup (chapter 5, kernel initialization). You can
try that.
Regards,
Pavan


On Wed, Oct 6, 2010 at 3:58 PM, Sri Ram Vemulpali
<sri.ram.gmu06@gmail.com> wrote:
> Hi all,
>
> =A0Can anyone, please help me on pointing to kernel boot code after
> grubs loads the kernel and transfers control to it.
> =A0I want in which files this resides, location. Any explanation on the
> code or any link would be helpful to me.
> =A0I know this is kind of lousy question, but entry.S is where I looked
> at. It is overwhelming for me where to start in that file.
> =A0Thanks in advance.
>
> --
> Regards,
> Sri.
>
> --
> To unsubscribe from this list: send an email with
> "unsubscribe kernelnewbies" to ecartis@nl.linux.org
> Please read the FAQ at http://kernelnewbies.org/FAQ
>
>

--
To unsubscribe from this list: send an email with
"unsubscribe kernelnewbies" to ecartis@nl.linux.org
Please read the FAQ at http://kernelnewbies.org/FAQ

=0A=0A
--0-2108819066-1286426396=:36232
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This=
 may help you pretty old,<br>http://tldp.org/HOWTO/Linux-i386-Boot-Code-HOW=
TO/<br><br><br><br><br>--- On <b>Thu, 7/10/10, Pavan Kandepet <i>&lt;pavank=
p@gmail.com&gt;</i></b> wrote:<br><blockquote style=3D"border-left: 2px sol=
id rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"><br>From: Pavan =
Kandepet &lt;pavankp@gmail.com&gt;<br>Subject: Re: Kernel start code<br>To:=
 "Sri Ram Vemulpali" &lt;sri.ram.gmu06@gmail.com&gt;<br>Cc: "Kernel-newbies=
" &lt;kernelnewbies@nl.linux.org&gt;, "Linux-rt-users" &lt;linux-rt-users@v=
ger.kernel.org&gt;<br>Date: Thursday, 7 October, 2010, 4:49 AM<br><br><div =
class=3D"plainMail">Embedded Linux primer has a good introduction to<br>ker=
nel bootup (chapter 5, kernel initialization). You can<br>try that.<br>Rega=
rds,<br>Pavan<br><br><br>On Wed, Oct 6, 2010 at 3:58 PM, Sri Ram
 Vemulpali<br>&lt;<a ymailto=3D"mailto:sri.ram.gmu06@gmail.com" href=3D"/mc=
/compose?to=3Dsri.ram.gmu06@gmail.com">sri.ram.gmu06@gmail.com</a>&gt; wrot=
e:<br>&gt; Hi all,<br>&gt;<br>&gt; &nbsp;Can anyone, please help me on poin=
ting to kernel boot code after<br>&gt; grubs loads the kernel and transfers=
 control to it.<br>&gt; &nbsp;I want in which files this resides, location.=
 Any explanation on the<br>&gt; code or any link would be helpful to me.<br=
>&gt; &nbsp;I know this is kind of lousy question, but entry.S is where I l=
ooked<br>&gt; at. It is overwhelming for me where to start in that file.<br=
>&gt; &nbsp;Thanks in advance.<br>&gt;<br>&gt; --<br>&gt; Regards,<br>&gt; =
Sri.<br>&gt;<br>&gt; --<br>&gt; To unsubscribe from this list: send an emai=
l with<br>&gt; "unsubscribe kernelnewbies" to <a ymailto=3D"mailto:ecartis@=
nl.linux.org" href=3D"/mc/compose?to=3Decartis@nl.linux.org">ecartis@nl.lin=
ux.org</a><br>&gt; Please read the FAQ at <a href=3D"http://kernelnewbies.o=
rg/FAQ"
 target=3D"_blank">http://kernelnewbies.org/FAQ</a><br>&gt;<br>&gt;<br><br>=
--<br>To unsubscribe from this list: send an email with<br>"unsubscribe ker=
nelnewbies" to <a ymailto=3D"mailto:ecartis@nl.linux.org" href=3D"/mc/compo=
se?to=3Decartis@nl.linux.org">ecartis@nl.linux.org</a><br>Please read the F=
AQ at <a href=3D"http://kernelnewbies.org/FAQ" target=3D"_blank">http://ker=
nelnewbies.org/FAQ</a><br><br></div></blockquote></td></tr></table><br>
--0-2108819066-1286426396=:36232--

--
To unsubscribe from this list: send an email with
"unsubscribe kernelnewbies" to ecartis@nl.linux.org
Please read the FAQ at http://kernelnewbies.org/FAQ
