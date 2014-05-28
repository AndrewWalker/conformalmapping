function out = char(map)
%CHAR   Pretty-print a Moebius transformation.

%   Copyright (c) 1998-2006 by Toby Driscoll.
%   $Id$

% Numerator
num = '';
a = map.matrix(1,1);
if a~=0
  if a~=1
    if isreal(a)
      num = [num num2str(a,4) '*'];
    elseif isreal(1i*a)
      num = [num num2str(imag(a),4) 'i*'];
    else
      num = [num '(' num2str(a,4) ')*'];
    end
  end
  num = [num 'z'];
end
a = map.matrix(1,2);
if a~=0
  if ~isempty(num)
    s = sign(real(a));
    if s==0, s = sign(imag(a)); end
    if s > 0
      num = [num ' + '];
    else
      num = [num ' - '];
      a = -a;
    end
  end
  if isreal(a)
    num = [num num2str(a,4)];
  elseif isreal(1i*a)
    num = [num num2str(imag(a),4) 'i'];
  else
    num = [num '(' num2str(a,4) ')'];
  end
end

% Denominator
den = '';
a = map.matrix(2,1);
if a~=0
  if a~=1
    if isreal(a) 
      den = [den num2str(a,4) '*'];
    elseif isreal(1i*a)
      den = [den num2str(imag(a),4) 'i*'];
    else
      den = [den '(' num2str(a,4) ')*'];
    end
  end
  den = [den 'z'];
end
a = map.matrix(2,2);
if a~=0
  if ~isempty(den)
    s = sign(real(a));
    if s==0, s = sign(imag(a)); end
    if s > 0
      den = [den ' + '];
    else
      den = [den ' - '];
      a = -a;
    end
  end
  if isreal(a)
    den = [den num2str(a,4)];
  elseif isreal(1i*a)
      den = [den num2str(imag(a),4) 'i'];
  else
    den = [den '(' num2str(a,4) ')'];
  end
end

L = [length(num),length(den)];
D = (max(L)-L)/2;
num = [blanks(floor(D(1))) num blanks(ceil(D(1)))];
den = [blanks(floor(D(2))) den blanks(ceil(D(2)))];
fline = repmat('-',1,max(L));

out = sprintf('\n  %s\n  %s\n  %s\n\n',num,fline,den);