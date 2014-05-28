function plot(d,varargin)

newplot
washold = ishold;

% Draw inner boundary
if ~isempty(d.innerboundary)
  hin = plot(d.innerboundary);
  zin = get(hin,'xdata') + 1i*get(hin,'ydata');
  zin = zin(:);
  delete(hin)
else
  zin = [];
end

if ~isempty(d.outerboundary)
  hout = plot(d.outerboundary);
  zout = get(hout,'xdata') + 1i*get(hout,'ydata');
  delete(hout)
else
  axlim = axis;
  midpt = [mean(axlim(1:2)) mean(axlim(3:4))];
  width = [diff(axlim(1:2)) diff(axlim(3:4))];
  xbox = midpt(1) + width(1)*0.75*[-1 1];
  ybox = midpt(2) + width(2)*0.75*[-1 1];
  axis([xbox ybox])
  zout = xbox([1 1 2 2]) + 1i*ybox([2 1 1 2]);
  [tmp,idx] = min( abs( zout - zin(1) ) );
  zout = zout([idx:4 1:idx]);
end

zall = [zout(:); zin(end:-1:1)];
settings = { [0.75 0.75 0.85],'edgecolor','none',varargin{:}};
h = fill(real(zall),imag(zall),settings{:});

hold on
if ~isempty(d.outerboundary), plot(d.outerboundary,varargin{:}), end
if ~isempty(d.innerboundary), plot(d.innerboundary,varargin{:}), end

if ~washold, hold off, end