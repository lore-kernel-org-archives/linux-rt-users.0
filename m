From: Raz <raziebe@gmail.com>
Subject: Re: segmentation question
Date: Sat, 2 Oct 2010 12:15:04 +0200
Message-ID: <AANLkTi=PbFW7wuk2U_Xs=RuzTBj17frYTyCbx_Tw6rXi@mail.gmail.com>
References: <AANLkTinfuURBV9-4=OhgojKWpRZh8QdPSVkeay71wm=D@mail.gmail.com>
	<AANLkTikV_opDwuP=N6CzE1qQr9GXPznaJUY2R3GR7K--@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=00151747b326bdfa6d04919f952f
Cc: Linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>, Kernel-newbies <kernelnewbies@nl.linux.org>,
	Bond <jamesbond.2k.g@gmail.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Return-path: <kernelnewbies-bounce@nl.linux.org>
In-Reply-To: <AANLkTikV_opDwuP=N6CzE1qQr9GXPznaJUY2R3GR7K--@mail.gmail.com>
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

--00151747b326bdfa6d04919f952f
Content-Type: text/plain; charset=ISO-8859-1

Can you share the code?

On 02/10/2010 12:10, "Daniel Baluta" <daniel.baluta@gmail.com> wrote:

Hi,

On Sat, Oct 2, 2010 at 12:38 AM, Sri Ram Vemulpali

<sri.ram.gmu06@gmail.com> wrote:

> Hi All,
>
>      I am developing segmentation for my kernel. In that process I
> choose to divide ...
You don't have to "tell" your processor to choose only 16-bit offset.
If the offset is greater than segment limit an exception will occur.



>
> Any insight in to this will help me. please clarify my doubt. Waiting
> for you reply.

> To unsubscribe from this list: send an email with
> "unsubscribe kernelnewbies" to ecartis@nl.linu...
@Bond: GTD should be GDT.Also please have a look inside x86 reference
manual.

thanks,
Daniel.


--
To unsubscribe from this list: send an email with
"unsubscribe kernelnewbies" to ecartis@nl.linu...

--00151747b326bdfa6d04919f952f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Can you share the code?</p>
<p><blockquote type=3D"cite">On 02/10/2010 12:10, &quot;Daniel Baluta&quot;=
 &lt;<a href=3D"mailto:daniel.baluta@gmail.com">daniel.baluta@gmail.com</a>=
&gt; wrote:<br><br>Hi,<br>
<br>
On Sat, Oct 2, 2010 at 12:38 AM, Sri Ram Vemulpali<br>
<p><font color=3D"#500050">&lt;<a href=3D"mailto:sri.ram.gmu06@gmail.com">s=
ri.ram.gmu06@gmail.com</a>&gt; wrote:</font></p><p><font color=3D"#500050">=
&gt; Hi All,<br>&gt;<br>&gt; =A0 =A0 =A0I am developing segmentation for my=
 kernel. In that process I<br>
&gt; choose to divide ...</font></p>You don&#39;t have to &quot;tell&quot; =
your processor to choose only 16-bit offset.<br>
If the offset is greater than segment limit an exception will occur.<br>
<p><font color=3D"#500050"><br><br>&gt;<br>&gt; Any insight in to this will=
 help me. please clarify my doubt. Waiting<br>&gt; for you reply.<br></font=
></p><p><font color=3D"#500050">&gt; To unsubscribe from this list: send an=
 email with<br>
&gt; &quot;unsubscribe kernelnewbies&quot; to ecartis@nl.linu...</font></p>=
@Bond: GTD should be GDT.Also please have a look inside x86 reference manua=
l.<br>
<br>
thanks,<br>
<font color=3D"#888888">Daniel.<br>
</font><p><font color=3D"#500050"><br>--<br>To unsubscribe from this list: =
send an email with<br>&quot;unsubscribe kernelnewbies&quot; to ecartis@nl.l=
inu...</font></p></blockquote></p>

--00151747b326bdfa6d04919f952f--

--
To unsubscribe from this list: send an email with
"unsubscribe kernelnewbies" to ecartis@nl.linux.org
Please read the FAQ at http://kernelnewbies.org/FAQ
